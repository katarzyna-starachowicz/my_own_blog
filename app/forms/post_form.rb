class PostForm
  include Virtus.model
  include ActiveModel::Model

  attribute :user_id,     Integer
  attribute :title,       String
  attribute :body,        String
  attribute :id,          Integer

  validates :title, :body, :user_id, presence: true

  def persisted?
    !id.blank?
  end
end
