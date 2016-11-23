class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    comment = comment_service.user_publishes_new_comment(
        comment_form_params, commentable, current_user
      )
    if comment.valid?
      redirect_to :back, notice: I18n.t("shared.created", resource: 'comment').capitalize
    else
      redirect_to :back, notice: 'Something went wrong...'
    end
  end

  private

  def repo
    @comment_repo ||= CommentRepo.new
  end

  def comment_service
    @comment_service ||= CommentService.new(repo)
  end

  def comment_form_params
    params.require(:comment).permit(:body)
  end

  def commentable
    return { 'Post' => params[:post_id] } if params[:post_id]
    { 'Comment' => params[:comment_id] }  if params[:comment_id]
  end
end
