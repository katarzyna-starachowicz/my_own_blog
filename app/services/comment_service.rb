class CommentService
  def initialize(comment_repo)
    @comment_repo = comment_repo
  end

  def user_writes_new_comment
    CommentForm.new
  end
end
