module Admin
  class PostsController < ApplicationController
    before_action :authenticate_admin!

    def new
      post = post_service.admin_writes_new_post
      render_with_form :new, post
    end

    def create
      post = post_service.admin_publishes_new_post(post_form_params, current_user)
      if post.valid?
        redirect_to post, locals: { post: post }, notice: i18n_post('created')
      else
        render_with_form :new, post
      end
    end

    def edit
      post = post_service.admin_edits_post(params[:id], current_user)
      render_with_form :edit, post
    rescue PostService::Unauthorized => e
      redirect_to post_path(params[:id]), notice: e.message
    end

    def update
      post = post_service.admin_publishes_edited_post(params[:id], post_form_params, current_user)
      if post.valid?
        redirect_to post, locals: { post: post }, notice: i18n_post('updated')
      else
        render_with_form :edit, post
      end
    rescue PostService::Unauthorized => e
      redirect_to post_path(params[:id]), notice: e.message
    end

    def destroy
      post = post_service.admin_destroys_post(params[:id], current_user)
      if post.try(:valid?)
        redirect_to posts_path, notice: i18n_post('deleted')
      else
        redirect_to post_path(post), notice: i18n_post('unauthorized_destroy')
      end
    end

    private

    def repo
      @post_repo ||= PostRepo.new
    end

    def post_service
      @post_service ||= PostService.new(repo)
    end

    def render_with_form(template, post_form)
      render template, locals: { post: post_form }
    end

    def post_form_params
      params.require(:post).permit(:title, :body)
    end

    def i18n_post(action)
      I18n.t("shared.#{action}", resource: 'post').capitalize
    end
  end
end
