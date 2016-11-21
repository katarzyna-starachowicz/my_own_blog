require 'rails_helper'

RSpec.describe CommentService do
  subject(:service)  { described_class.new(comment_repo) }
  let(:comment_repo) { CommentRepo.new }

  describe '#user_writes_new_comment' do
    it 'returns an empty comment form' do
      expect(service.user_writes_new_comment.to_h).to eql CommentForm.new.to_h
    end
  end
end
