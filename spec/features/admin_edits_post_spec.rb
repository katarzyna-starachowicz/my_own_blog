require 'rails_helper'

feature 'Admin edits post' do
  let(:admin) { create :user, :admin }
  let!(:post) { create :post, user_id: admin.id }

  let!(:not_admins_post) { create :post }

  before do
    sign_in_as(admin)
    click_on 'All posts'
    click_on post.title
    click_on 'Edit'
  end

  scenario 'with valid input' do
    fill_in 'Title', with: 'How to be happy?'
    fill_in 'Body',  with: 'The answer for that question does not exist.'
    click_button 'Publish'

    expect(page).to have_content 'Post was successfully updated.'
  end

  scenario 'without title input' do
    fill_in 'Title', with: ' '
    click_button 'Publish'

    expect(page).to have_content "Title can't be blank"
  end

  scenario 'without body input' do
    fill_in 'Body', with: ' '
    click_button 'Publish'

    expect(page).to have_content "Body can't be blank"
  end

  scenario 'can not edit not his own post' do
    click_on 'All posts'
    click_on not_admins_post.title

    expect(page).not_to have_content 'Edit'
  end
end
