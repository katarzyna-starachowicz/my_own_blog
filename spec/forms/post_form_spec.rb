require 'rails_helper'

RSpec.describe PostForm do
  subject(:post_form) { described_class.new(attributes) }

  let(:id)      { nil }
  let(:body)    { 'I love writing posts!' }
  let(:title)   { 'My first post' }
  let(:user_id) { 1 }
  let(:attributes) do
    {
      id:      id,
      title:   title,
      body:    body,
      user_id: user_id
    }
  end

  context 'with valid attributes' do
    it { is_expected.to be_valid }
  end

  context 'without body' do
    let(:body) { nil }

    it { is_expected.not_to be_valid }
  end

  context 'without title' do
    let(:title) { nil }

    it { is_expected.not_to be_valid }
  end

  context 'without user_id' do
    let(:user_id) { nil }

    it { is_expected.not_to be_valid }
  end

  describe '#self.model_name' do
    let(:model_name) { 'Post' }

    it_behaves_like '#self.model_name'
  end

  describe '#persisted?' do
    subject(:form) { post_form }

    it_behaves_like '#persisted?'
  end
end
