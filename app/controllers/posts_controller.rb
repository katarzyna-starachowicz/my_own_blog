class PostsController < ApplicationController
  def index
    posts = repo.all_from_the_last
    render 'posts/index', locals: { posts: posts }
  end

  def show
    post = repo.find(params[:id])
    render 'posts/show', locals: { post: post }
  end

  private

  def repo
    @posts_repo ||= PostsRepo.new
  end
end
