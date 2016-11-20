require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user)  { create(:user) }
  let(:admin) { create(:user, :admin) }

  let!(:admin_post)   { create(:post, user_id: admin.id) }
  let!(:another_post) { create(:post) }
  let!(:params) do
    {
      post_form:
        {
          title: 'title',
          body: 'body',
          user_id: admin.id
        }
    }
  end

  describe 'GET #index' do
    subject { get :index }

    it_behaves_like 'template rendering and http success returning', :index
  end

  describe 'GET #show' do
    subject { get :show, id: admin_post.id }

    it_behaves_like 'template rendering and http success returning', :show
  end

  context 'when user is an admin' do
    before { sign_in admin }

    describe 'GET #new' do
      subject { get :new }

      it_behaves_like 'template rendering and http success returning', :new
    end

    describe 'POST #create' do
      subject { post :create, params }

      context 'success' do
        it { is_expected.to redirect_to post_path(Post.find_by(title: 'title')) }

        it 'flashes info' do
          subject
          expect(flash[:notice]).to eq 'Post was successfully created.'
        end

        it 'creates post' do
          expect{ subject }.to change(Post, :count).by(1)
        end
      end

      context 'failure' do
        before { params[:post_form][:title] = '' }

        it_behaves_like 'template rendering and http success returning', :new
      end
    end

    describe 'GET #edit' do
      context 'when admin want to edit his own post' do
        subject { get :edit, id: admin_post.id }

        it_behaves_like 'template rendering and http success returning', :edit
      end

      context 'when admin want to edit not his post' do
        subject { get :edit, id: another_post.id }

        it { is_expected.to redirect_to post_path(another_post) }

        it 'flashes info' do
          subject
          expect(flash[:notice]).to eq('You can not edit that post.')
        end
      end
    end

    describe 'PUT #update' do
      subject { put :update, params }

      context 'when admin want to update his own post' do
        before { params[:id] = admin_post.id }

        context 'success' do
          it { is_expected.to redirect_to post_path(admin_post.id) }

          it 'flashes info' do
            subject
            expect(flash[:notice]).to eq 'Post was successfully updated.'
          end
        end

        context 'failure' do
         before { params[:post_form][:title] = '' }

          it { is_expected.to render_template :edit, id: admin_post.id }
        end
      end

      context 'when admin want to update not his own post' do
        before { params[:id] = another_post.id }

        it { is_expected.to redirect_to post_path(another_post) }

        it 'flashes info' do
          subject
          expect(flash[:notice]).to eq('You can not edit that post.')
        end
      end
    end

    describe 'DELETE #destroy' do
      context 'when admin want to delete his own post' do
        subject { delete :destroy, id: admin_post.id }

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
        subject { delete :destroy, id: another_post.id }

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

    describe 'POST #create' do
      subject { post :create, params }

      it_behaves_like 'redirecting user to admin sign in page'
    end

    describe 'GET #edit' do
      subject { get :edit, id: admin_post.id }

      it_behaves_like 'redirecting user to admin sign in page'
    end

    describe 'PUT #update' do
      subject { put :update, params }
      before  { params[:id] = admin_post.id }

      it_behaves_like 'redirecting user to admin sign in page'
    end

    describe 'DELETE #destroy' do
      subject { delete :destroy, id: admin_post.id }

      it_behaves_like 'redirecting user to admin sign in page'
    end
  end
end
