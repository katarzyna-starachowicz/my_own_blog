require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe 'GET #new' do
    subject { get :new }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
  end
end
