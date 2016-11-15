class PostsController < ApplicationController
  def index
    posts = repo.all_from_the_last

    render 'posts/index', locals: { posts: posts }
  end

  private

  def repo
    @posts_repo ||= PostsRepo.new
  end
end
