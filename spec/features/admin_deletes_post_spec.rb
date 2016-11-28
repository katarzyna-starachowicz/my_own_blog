require 'rails_helper'

feature 'Admin deletes post' do
  let(:admin) { create :user, :admin }
  let!(:post) { create :post, user_id: admin.id }

  let!(:not_admins_post) { create :post }

  before do
    sign_in_as admin
    click_on 'All posts'
  end

  scenario 'with valid input' do
    click_on post.title
    click_on 'Delete'

    expect(page).to have_content 'Post was successfully deleted.'
  end

  scenario 'can not delete not his own post' do
    click_on not_admins_post.title

    expect(page).not_to have_content 'Delete'
  end
end
