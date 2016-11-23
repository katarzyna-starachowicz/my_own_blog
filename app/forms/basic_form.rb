class BasicForm
  include Virtus.model
  include ActiveModel::Model

  attribute :id, Integer

  def self.model_name
    ActiveModel::Name.new(self, nil, name.gsub(/Form\Z/, ''))
  end

  def persisted?
    id.present?
  end
end
