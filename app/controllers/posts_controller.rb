class PostsController < ApplicationController
  before_action :authenticate_admin!, except: [:index, :show]

  def index
    posts = PostsQuery.new.all_from_the_last
    render :index, locals: { posts: posts }
  end

  def show
    post = repo.find(params[:id])
    render :show, locals: { post: post }
  end

  def new
    render_with_form :new, PostForm.new
  end

  def create
    post_form = PostForm.new(
      post_form_params.merge(user_id: current_user.id)
    )

    if post_form.valid?
      post = repo.create(post_form)
      redirect_to post, locals: { post: post }, notice: 'Post was successfully created.'
    else
      render_with_form :new, post_form
    end
  end

  def edit
    post = repo.find_admins_post(current_user.id, params[:id])
    post_form = PostForm.new(
      id:      params[:id],
      user_id: post.user_id,
      title:   post.title,
      body:    post.body
    )
    render_with_form :edit, post_form
  end

  def update
    post_form = PostForm.new(
      post_form_params.merge(
        user_id: current_user.id,
        id: params[:id]
      )
    )
    if post_form.valid?
      post = repo.update(post_form)
      redirect_to post, locals: { post: post }, notice: 'Post was successfully updated.'
    else
      render_with_form :edit, post_form
    end
  end

  def destroy
    post = repo.find_admins_post(current_user.id, params[:id])
    if post.blank?
      redirect_to posts_path, notice: 'You can not destroy that post.'
    else
      repo.destroy(post)
      redirect_to posts_path, notice: 'Post was successfully destroyed.'
    end
  end

  private

  def repo
    @posts_repo ||= PostsRepo.new
  end

  def render_with_form(template, post_form)
    render template, locals: { post_form: post_form }
  end

  def post_form_params
    params.require(:post_form).permit(:title, :body)
  end
end
