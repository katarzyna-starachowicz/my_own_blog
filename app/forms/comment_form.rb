class CommentForm
  include Virtus.model
  include ActiveModel::Model

  attribute :id,               Integer
  attribute :body,             String
  attribute :commentator_name, String
  attribute :commentable_id,   Integer
  attribute :commentable_type, String

  validates :body,
            :commentator_name,
            :commentable_id,
            :commentable_type, presence: true

  validates :commentator_name, length: { maximum: 40,
                                         too_long: "must have at least %{count} characters." }

  def persisted?
    !id.blank?
  end
end
