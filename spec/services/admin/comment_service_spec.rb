require 'rails_helper'

RSpec.describe Admin::CommentService do
  subject(:service)  { described_class.new(comment_repo) }
  let(:comment_repo) { CommentRepo.new }
  let!(:comment)     { create(:comment) }

  describe '#admin_destroys_comment' do
    it 'deletes a comment' do
      expect { service.admin_destroys_comment(comment.id) }.
        to change { Comment.count }.by(-1)
    end
  end
end
