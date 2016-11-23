require 'rails_helper'

RSpec.describe Admin::PostsController, type: :controller do
  let(:user)  { create(:user) }
  let(:admin) { create(:user, :admin) }

  let!(:admin_post)   { create(:post, user_id: admin.id) }
  let!(:another_post) { create(:post) }
  let(:title)         { 'title' }
  let!(:params) do
    {
      post:
        {
          title: title,
          body: 'body',
          user_id: admin.id
        }
    }
  end

  context 'when user is an admin' do
    before { sign_in admin }

    describe 'GET #new' do
      subject(:action) { get :new }

      it_behaves_like 'template rendering and http success returning', :new
    end

    describe 'POST #create' do
      subject(:action) { post :create, params }

      context 'success' do
        it { is_expected.to redirect_to post_path(Post.find_by(title: 'title')) }

        it 'flashes info' do
          action
          expect(flash[:notice]).to eq 'Post was successfully created.'
        end

        it 'creates post' do
          expect { action }.to change(Post, :count).by(1)
        end
      end

      context 'failure' do
        let(:title) { nil }

        it_behaves_like 'template rendering and http success returning', :new
      end
    end

    describe 'GET #edit' do
      context 'when admin want to edit his own post' do
        subject(:action) { get :edit, id: admin_post.id }

        it_behaves_like 'template rendering and http success returning', :edit
      end

      context 'when admin want to edit not his post' do
        subject(:action) { get :edit, id: another_post.id }

        it { is_expected.to redirect_to post_path(another_post) }

        it 'flashes info' do
          action
          expect(flash[:notice]).to eq('You can not edit that post.')
        end
      end
    end

    describe 'PUT #update' do
      subject(:action) { put :update, params }

      context 'when admin want to update his own post' do
        before { params[:id] = admin_post.id }

        context 'success' do
          it { is_expected.to redirect_to post_path(admin_post.id) }

          it 'flashes info' do
            action
            expect(flash[:notice]).to eq 'Post was successfully updated.'
          end
        end

        context 'failure' do
          let(:title) { nil }

          it { is_expected.to render_template :edit, id: admin_post.id }
        end
      end

      context 'when admin want to update not his own post' do
        before { params[:id] = another_post.id }

        it { is_expected.to redirect_to post_path(another_post) }

        it 'flashes info' do
          action
          expect(flash[:notice]).to eq('You can not edit that post.')
        end
      end
    end

    describe 'DELETE #destroy' do
      context 'when admin want to delete his own post' do
        subject(:action) { delete :destroy, id: admin_post.id }

        it { is_expected.to redirect_to posts_path }

        it 'flashes info' do
          action
          expect(flash[:notice]).to eq 'Post was successfully deleted.'
        end

        it 'destroys post' do
          expect { action }.to change(Post, :count).by(-1)
        end
      end

      context 'when admin want to delete not his own post' do
        subject(:action) { delete :destroy, id: another_post.id }

        it { is_expected.to redirect_to post_path(another_post.id) }

        it 'flashes info' do
          action
          expect(flash[:notice]).to eq 'You can not destroy that post.'
        end

        it 'does not destroy a post' do
          expect { action }.not_to change(Post, :count)
        end
      end
    end
  end

  context 'when user is not an admin' do
    before { sign_in user }

    describe 'GET #new' do
      subject(:action) { get :new }

      it_behaves_like 'redirecting user to admin sign in page'
    end

    describe 'POST #create' do
      subject(:action) { post :create, params }

      it_behaves_like 'redirecting user to admin sign in page'
    end

    describe 'GET #edit' do
      subject(:action) { get :edit, id: admin_post.id }

      it_behaves_like 'redirecting user to admin sign in page'
    end

    describe 'PUT #update' do
      subject(:action) { put :update, params }
      before { params[:id] = admin_post.id }

      it_behaves_like 'redirecting user to admin sign in page'
    end

    describe 'DELETE #destroy' do
      subject(:action) { delete :destroy, id: admin_post.id }

      it_behaves_like 'redirecting user to admin sign in page'
    end
  end
end
