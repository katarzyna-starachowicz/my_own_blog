require 'rails_helper'

RSpec.describe CommentRepo do
  subject(:repo) { described_class.new }

  let(:comment)  { create(:comment) }

  describe '#find' do
    it 'finds a post by id' do
      expect(repo.find(comment.id)).to eq(comment)
    end
  end

  describe '#create' do
    let(:form) do
      CommentForm.new(
        body:    'body',
        commentator_name: 'name',
        commentable_id: 1,
        commentable_type: 'Post'
      )
    end

    it 'creates a new comment' do
      expect { repo.create(form) }.to change { Comment.count }.by(1)
    end
  end
end
