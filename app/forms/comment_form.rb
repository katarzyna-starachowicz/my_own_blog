class CommentForm
  include Virtus.model
  include ActiveModel::Model

  def self.model_name
    ActiveModel::Name.new(self, nil, self.name.gsub(/Form\Z/, ''))
  end

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
    id.present?
  end
end
