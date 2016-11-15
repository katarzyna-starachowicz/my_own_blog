class PostForm
  include Virtus.model
  include ActiveModel::Validations

  attribute :user_id, Integer
  attribute :title,   String
  attribute :body,    String

  validates :title, :body, :user_id, presence: true
end
