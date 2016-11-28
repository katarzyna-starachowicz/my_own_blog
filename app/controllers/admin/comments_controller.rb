module Admin
  class CommentsController < ::ApplicationController
    before_action :authenticate_admin!

    def destroy
      comment = comment_service.admin_destroys_comment(params[:id])
      redirect_to :back, notice: I18n.t("shared.deleted", resource: 'comment').capitalize
    end

    private

    def repo
      @comment_repo ||= CommentRepo.new
    end

    def comment_service
      @comment_service ||= CommentService.new(repo)
    end
  end
end
