require 'rails_helper'

RSpec.describe CommentForm do
  subject(:comment_form) { described_class.new(attributes) }

  let(:id)               { nil }
  let(:body)             { 'Great article!' }
  let(:user_id)          { 1 }
  let(:commentable_id)   { 1 }
  let(:commentable_type) { 'Post' }
  let(:attributes) do
    {
      id:               id,
      body:             body,
      user_id:          user_id,
      commentable_id:   commentable_id,
      commentable_type: commentable_type
    }
  end

  context 'with valid attributes' do
    it { is_expected.to be_valid }
  end

  context 'without body' do
    let(:body) { nil }

    it { is_expected.not_to be_valid }
  end

  context 'without user_id' do
    let(:user_id) { nil }

    it { is_expected.not_to be_valid }
  end

  context 'without commentable_id' do
    let(:commentable_id) { nil }

    it { is_expected.not_to be_valid }
  end

  context 'without commentable_type' do
    let(:commentable_type) { nil }

    it { is_expected.not_to be_valid }
  end

  context 'with commentable_type antoher than Post or Comment' do
    let(:commentable_type) { 'User' }

    it { is_expected.not_to be_valid }
  end

  describe '#self.model_name' do
    let(:model_name) { 'Comment' }

    it_behaves_like '#self.model_name'
  end

  describe '#persisted?' do
    subject(:form) { comment_form }

    it_behaves_like '#persisted?'
  end
end
