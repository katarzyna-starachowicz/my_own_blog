class PostForm
  include Virtus.model
  include ActiveModel::Model

  attribute :user_id, Integer
  attribute :title,   String
  attribute :body,    String

  validates :title, :body, :user_id, presence: true

  def persisted?
    false
  end
end
