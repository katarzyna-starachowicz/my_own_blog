class CommentRepo
  def find(comment_id)
    Comment.find(comment_id)
  end

  def create(comment_form)
    Comment.create(
      body:             comment_form.body,
      commentator_name: comment_form.commentator_name,
      commentable_id:   comment_form.commentable_id,
      commentable_type: comment_form.commentable_type
    )
  end
end
