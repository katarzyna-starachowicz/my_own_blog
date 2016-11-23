class CommentService
  def initialize(comment_repo)
    @comment_repo = comment_repo
  end

  def user_publishes_new_comment(comment_attributes, commentable, user)
    comment_form = CommentForm.new(
        comment_attributes.merge(
            user_id:          user.id,
            commentable_id:   commentable.values.first,
            commentable_type: commentable.keys.first
          )
      )
    comment_form.valid? ? @comment_repo.create(comment_form) : comment_form
  end
end
