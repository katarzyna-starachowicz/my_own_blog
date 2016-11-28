require 'rails_helper'

RSpec.describe CommentRepo do
  subject(:repo) { described_class.new }

  let!(:comment) { create(:comment) }
  let(:user)     { create(:user) }
  let(:post)     { create(:post) }

  describe '#find' do
    it 'finds a post by id' do
      expect(repo.find(comment.id)).to eq(comment)
    end
  end

  describe '#create' do
    let(:form) do
      CommentForm.new(
        body:             'body',
        user_id:          user.id,
        commentable_id:   post.id,
        commentable_type: 'Post'
      )
    end

    it 'creates a new comment' do
      expect { repo.create(form) }.to change { Comment.count }.by(1)
    end
  end

  describe '#destroy' do
    let!(:comments_comment_1) { create(:comment, :on_comment, commentable_id: comment.id) }
    let!(:comments_comment_2) { create(:comment, :on_comment, commentable_id: comment.id) }
    let!(:comments_comment_1s_comments) do
      create(:comment, :on_comment, commentable_id: comments_comment_1.id)
    end

    it 'destroys a comment' do
      expect { repo.destroy(comments_comment_2.id) }.to change { Comment.count }.by(-1)
    end

    it 'destroys a comment with its comments' do
      expect { repo.destroy(comment.id) }.to change { Comment.count }.by(-4)
    end
  end
end
