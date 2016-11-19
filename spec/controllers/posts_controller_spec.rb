require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user)  { create(:user) }
  let(:admin) { create(:user, :admin) }
  let!(:post) { create(:post, user_id: admin.id) }

  describe 'GET #index' do
    subject { get :index }

    it_behaves_like 'template rendering and http success returning', :index
  end

  describe 'GET #show' do
    subject { get :show, id: post.id }

    it_behaves_like 'template rendering and http success returning', :show
  end

  context 'when user is an admin' do
    before { sign_in admin }

    describe 'GET #new' do
      subject { get :new }

      it_behaves_like 'template rendering and http success returning', :new
    end

    describe 'GET #edit' do
      subject { get :edit, id: post.id }

      context 'when admin want to edit his own post' do
        it_behaves_like 'template rendering and http success returning', :edit
      end

      context 'when admin want to edit not his post' do
        let(:post) { create(:post) }

        it { is_expected.to redirect_to post_path(post) }

        it 'flashes info' do
          subject
          expect(flash[:notice]).to eq('You can not edit that post.')
        end
      end
    end

    describe 'DELETE #destroy' do
      subject { delete :destroy, id: post.id }

      context 'when admin want to delete his own post' do
        subject { delete :destroy, id: post.id }

        it { is_expected.to redirect_to posts_path }

        it 'flashes info' do
          subject
          expect(flash[:notice]).to eq 'Post was successfully destroyed.'
        end

        it 'destroys post' do
          expect{ subject }.to change(Post, :count).by(-1)
        end
      end

      context 'when admin want to delete not his own post' do
        let!(:post) { create(:post) }

        it { is_expected.to redirect_to posts_path }

        it 'flashes info' do
          subject
          expect(flash[:notice]).to eq 'You can not destroy that post.'
        end

        it 'does not destroy a post' do
          expect{ subject }.not_to change(Post, :count)
        end
      end
    end
  end

  context 'when user is not an admin' do
    before { sign_in user }

    describe 'GET #new' do
      subject { get :new }

      it_behaves_like 'redirecting user to admin sign in page'
    end

    describe 'GET #edit' do
      subject { get :edit, id: post.id }

      it_behaves_like 'redirecting user to admin sign in page'
    end

    describe 'DELETE #destroy' do
      subject { delete :destroy, id: post }

      it_behaves_like 'redirecting user to admin sign in page'
    end
  end
end
