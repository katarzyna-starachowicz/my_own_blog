class CommentForm
  include Virtus.model
  include ActiveModel::Model

  attribute :id,               Integer
  attribute :body,             String
  attribute :user_id,          Integer
  attribute :commentable_id,   Integer
  attribute :commentable_type, String

  validates :body,
            :user_id,
            :commentable_id,
            :commentable_type, presence: true

  def persisted?
    !id.blank?
  end
end
