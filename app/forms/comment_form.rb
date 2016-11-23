class CommentForm < BasicForm
  attribute :body,             String
  attribute :user_id,          Integer
  attribute :commentable_id,   Integer
  attribute :commentable_type, String

  validates :body,
            :user_id,
            :commentable_id,
            :commentable_type, presence: true
  validates :commentable_type, inclusion: { in: %w(Post Comment) }
end
