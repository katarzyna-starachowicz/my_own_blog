require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe "GET #about_me" do
    subject { get :about_me }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it_behaves_like 'template rendering action', :about_me
  end
end
