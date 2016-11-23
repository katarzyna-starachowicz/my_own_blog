require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let!(:some_post) { create(:post) }

  describe 'GET #index' do
    subject(:action) { get :index }

    it_behaves_like 'template rendering and http success returning', :index
  end

  describe 'GET #show' do
    subject(:action) { get :show, id: some_post.id }

    it_behaves_like 'template rendering and http success returning', :show

    context 'when post does not exist' do
      subject(:action) { get :show, id: 0 }

      it { is_expected.to redirect_to posts_path }

      it 'flashes info' do
        action
        expect(flash[:notice]).to eq 'Sorry, the post not found.'
      end
    end
  end
end
