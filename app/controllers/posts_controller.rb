class PostsController < ApplicationController
  def index
    posts = post_service.load_all_posts
    render :index, locals: { posts: posts }
  end

  def show
    post = post_service.load_entire_post(params[:id])
    if post.try(:valid?)
      render :show, locals: { post: post }
    else
      redirect_to posts_path, notice: I18n.t('shared.not_found', resource: 'post').capitalize
    end
  end

  private

  def repo
    @post_repo ||= PostRepo.new
  end

  def post_service
    @post_service ||= PostService.new(repo)
  end
end
