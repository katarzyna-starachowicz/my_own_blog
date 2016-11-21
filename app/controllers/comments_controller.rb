class CommentsController < ApplicationController
  def new
    comment = comment_service.user_writes_new_comment
    render_with_form :new, comment
  end

  def create
  end

  private

  def repo
    @comment_repo ||= CommentRepo.new
  end

  def post_service
    @comment_service ||= CommentService.new(repo)
  end

  def render_with_form(template, comment_form)
    render template, locals: { comment_form: comment_form }
  end
end
