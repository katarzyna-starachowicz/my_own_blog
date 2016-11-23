require 'rails_helper'

RSpec.describe CommentService do
  let(:comment_repo)       { CommentRepo.new }
  let(:body)               { 'Great article!' }
  let(:comment_attributes) { { body: body } }
  let(:post)               { create(:post) }
  let(:commentable)        { { 'Post' => post.id } }
  let(:user)               { create(:user) }

  describe '#user_publishes_new_comment' do
    subject(:service_publishing_new_comment) do
      described_class.new(comment_repo).
        user_publishes_new_comment(comment_attributes, commentable, user)
    end

    context 'when attributes are valid' do
      it { is_expected.to be_an_instance_of Comment }
      it { expect { service_publishing_new_comment }.to change { Comment.count }.by(1) }
    end

    context 'when attributes are invalid' do
      let(:body) { nil }

      it { is_expected.to be_an_instance_of CommentForm }
      it { expect { service_publishing_new_comment }.not_to change { Comment.count } }
    end
  end
end
