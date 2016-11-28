module Admin
  class CommentService
    def initialize(comment_repo)
      @comment_repo = comment_repo
    end

    def admin_destroys_comment(comment_id)
      @comment_repo.destroy(comment_id)
    end
  end
end
