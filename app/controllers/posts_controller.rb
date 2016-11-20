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
    post = post_service.admin_publishes_new_post(post_form_params, current_user)
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
    post = post_service.admin_publishes_edited_post(params[:id], post_form_params, current_user)
    if post.try(:valid?).nil?
      redirect_to post_path(post), notice: 'You can not edit that post.'
    elsif post.valid?
      redirect_to post, locals: { post: post }, notice: 'Post was successfully updated.'
    else
      render_with_form :edit, post
    end
  end

  def destroy
    post = post_service.admin_destroys_post(params[:id], current_user)
    if post.try(:valid?)
      redirect_to posts_path, notice: 'Post was successfully destroyed.'
    else
      redirect_to post_path(post), notice: 'You can not destroy that post.'
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
