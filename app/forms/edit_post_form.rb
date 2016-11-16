class EditPostForm
  include Virtus.model
  include ActiveModel::Model

  attribute :user_id, Integer
  attribute :title,   String
  attribute :body,    String
  attribute :id,      Integer

  validates :id, :title, :body, :user_id, presence: true

  def persisted?
    true
  end
end
