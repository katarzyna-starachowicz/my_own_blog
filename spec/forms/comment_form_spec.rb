require 'rails_helper'

RSpec.describe CommentForm do
  subject(:comment_form) { described_class.new(attributes) }

  let(:attributes) do
    {
      body:             'Great article!',
      user_id:          1,
      commentable_id:   1,
      commentable_type: 'Post'
    }
  end

  it 'is valid with valid attributes' do
    expect(comment_form.valid?).to be true
  end

  it 'is invalid without body' do
    attributes[:body] = nil
    expect(comment_form.valid?).to be false
  end

  it 'is invalid without user_id' do
    attributes[:user_id] = nil
    expect(comment_form.valid?).to be false
  end

  it 'is invalid without commentable_id' do
    attributes[:commentable_id] = nil
    expect(comment_form.valid?).to be false
  end

  it 'is invalid without commentable_type' do
    attributes[:commentable_type] = nil
    expect(comment_form.valid?).to be false
  end

  it 'returns model name' do
    expect(described_class.model_name.name).to eq 'Comment'
  end

  describe '#persisted?' do
    let(:form) { comment_form }

    it_behaves_like '#persisted?'
  end
end
