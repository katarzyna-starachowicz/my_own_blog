class PostForm < BasicForm
  attribute :body,    String
  attribute :title,   String
  attribute :user_id, Integer

  validates :body, :title, :user_id, presence: true
end
