require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:commented_post) { create(:post) }
  let(:params)         { { comment: { body: body }, post_id: commented_post.id } }
  let(:body)           { 'Great article!' }
  let(:user)           { create(:user) }

  before do
    sign_in user
    request.env["HTTP_REFERER"] = "http://test.host/posts/#{commented_post.id}"
  end

  describe 'POST #create' do
    subject(:action) { post :create, params }

    context 'success' do
      it { is_expected.to redirect_to :back }

      it 'flashes info' do
        action
        expect(flash[:notice]).to eq I18n.t("shared.created", resource: 'comment').capitalize
      end

      it 'creates comment for post' do
        expect { action }.to change { Post.find(commented_post.id).comments.count }.by(1)
      end
    end

    context 'failure' do
      let(:body) { nil }

      it { is_expected.to redirect_to :back }

      it 'flashes info' do
        action
        expect(flash[:notice]).to eq 'Something went wrong...'
      end

      it 'does not create comment' do
        expect { action }.not_to change(Comment, :count)
      end
    end

    context 'user is not logged in' do
      before { sign_out user }

      it { is_expected.to redirect_to new_user_session_path }
    end
  end
end
