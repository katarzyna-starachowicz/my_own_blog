class CommentRepo
  def find(comment_id)
    Comment.find(comment_id)
  end

  def create(comment_form)
    Comment.create(
      body:             comment_form.body,
      user_id:          comment_form.user_id,
      commentable_id:   comment_form.commentable_id,
      commentable_type: comment_form.commentable_type
    )
  end

  def destroy(comment_id)
    find(comment_id).destroy
  end
end
