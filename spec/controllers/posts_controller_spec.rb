require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe "GET #index" do
    subject { get :index }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it_behaves_like 'template rendering action', :index
  end

  describe "GET #show" do
    subject    { get :show, id: post.id }
    let(:post) { create(:post) }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it_behaves_like 'template rendering action', :show
  end
end
