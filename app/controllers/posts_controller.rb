class PostsController < ApplicationController
  before_action :authenticate_admin!, except: [:index, :show]

  def index
    posts = repo.all_from_the_last
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
    form = PostForm.new(
      post_form_params.merge(user_id: current_user.id)
    )

    if form.valid?
      post = repo.create(form)
      redirect_to post, locals: { post: post }
    else
      render_with_form :new, form
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
