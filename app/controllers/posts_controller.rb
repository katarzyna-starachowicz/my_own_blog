class PostsController < ApplicationController
  before_action :authenticate_admin!, except: [:index, :show]

  def index
    posts = post_service.load_all_posts
    render :index, locals: { posts: posts }
  end

  def show
    post = post_service.load_entire_post(params[:id])
    render :show, locals: { post: post }
  end

  def new
    post = post_service.load_empty_post_form
    render_with_form :new, post
  end

  def create
    post = post_service.admin_publishes_post(post_form_params, current_user)
    if post.valid?
      redirect_to post, locals: { post: post }, notice: 'Post was successfully created.'
    else
      render_with_form :new, post
    end
  end

  def edit
    post = post_service.admin_edits_post(params[:id], current_user)
    if post.try(:valid?)
      render_with_form :edit, post
    else
      redirect_to post_path(post), notice: 'You can not edit that post.'
    end
  end

  def update
    # I know it's awful, it will be refactored in few next steps...
    post = repo.find_admins_post(current_user.id, params[:id])
    if post.blank?
      redirect_to post_path(repo.find(params[:id])), notice: 'You can not edit that post.'
    else
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
  end

  def destroy
    post = repo.find_admins_post(current_user.id, params[:id])
    if post.blank?
      redirect_to posts_path, notice: 'You can not destroy that post.'
    else
      repo.destroy(post.id)
      redirect_to posts_path, notice: 'Post was successfully destroyed.'
    end
  end

  private

  def repo
    @posts_repo ||= PostsRepo.new
  end

  def post_service
    @post_service ||= PostService.new(repo)
  end

  def render_with_form(template, post_form)
    render template, locals: { post_form: post_form }
  end

  def post_form_params
    params.require(:post_form).permit(:title, :body)
  end
end
