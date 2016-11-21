require 'rails_helper'

RSpec.describe CommentForm do
  subject(:comment_form) { described_class.new(attributes) }

  let(:attributes) do
    {
      body: 'Great article!',
      commentator_name: 'DHH',
      commentable_id: 1,
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

  it 'is invalid without commentators name' do
    attributes[:commentator_name] = nil
    expect(comment_form.valid?).to be false
  end

  context 'when commentators name is longer than 40 characters' do
    before { attributes[:commentator_name] = 'A' * 41 }

    it 'is invalid' do
      expect(comment_form.valid?).to be false
    end

    it 'has error message' do
      comment_form.valid?
      expect(comment_form.errors.full_messages).
        to include 'Commentator name must have at least 40 characters.'
    end
  end

  it 'is invalid without commentable_id' do
    attributes[:commentable_id] = nil
    expect(comment_form.valid?).to be false
  end

  it 'is invalid without commentable_type' do
    attributes[:commentable_type] = nil
    expect(comment_form.valid?).to be false
  end

  describe '#persisted?' do
    let(:form) { comment_form }

    it_behaves_like '#persisted?'
  end
end
