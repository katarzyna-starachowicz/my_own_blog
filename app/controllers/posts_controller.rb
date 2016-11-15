class PostsController < ApplicationController
  before_action :authenticate_admin!, except: [:index, :show]

  def index
    posts = repo.all_from_the_last
    render :index, locals: { posts: posts }
  end

  def show
    post = repo.find(params[:id])
    render_with_locals :show, post
  end

  def new
    render_with_locals :new, repo.new
  end

  def create
    form = PostForm.new(
      post_params.merge(user_id: current_user.id)
    )

    if form.valid?
      post = repo.create(form)
      redirect_to post, locals: { post: post }
    else
      render_with_locals :new, repo.new(form)
    end
  end

  private

  def repo
    @posts_repo ||= PostsRepo.new
  end

  def render_with_locals(template, post)
    render template, locals: { post: post }
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
