require 'rails_helper'

RSpec.describe Admin::CommentsController, type: :controller do
  let(:user)    { create(:user) }
  let(:admin)   { create(:user, :admin) }

  let(:commented_post) { create(:post) }
  let!(:comment) do
    create(:comment,
      commentable_id:   commented_post.id,
      commentable_type: 'Post'
    )
  end

  before { request.env["HTTP_REFERER"] = "http://test.host/posts/#{commented_post.id}" }

  describe 'DELETE #destroy' do
    subject(:action) { delete :destroy, post_id: commented_post.id, id: comment.id }

    context 'when user is not admin' do
      before { sign_in user }

      it_behaves_like 'redirecting user to admin sign in page'
    end

    context 'when user is admin' do
      before { sign_in admin }

      it { is_expected.to redirect_to :back }

      it 'flashes info' do
        action
        expect(flash[:notice]).to eq 'Comment was successfully deleted.'
      end

      it 'destroys comment' do
        expect { action }.to change(Comment, :count).by(-1)
      end
    end
  end
end
