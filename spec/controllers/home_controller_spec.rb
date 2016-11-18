require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe "GET #about_me" do
    subject { get :about_me }

    it_behaves_like 'template rendering and http success returning', :about_me
  end
end
