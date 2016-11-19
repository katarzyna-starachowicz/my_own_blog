require 'rails_helper'

feature 'Admin creates post' do
  let(:admin) { create :user, :admin }

  before do
    sign_in_as(admin)
    visit new_post_path
  end

  scenario 'with valid input' do
    fill_in 'Title', with: 'How to be happy?'
    fill_in 'Body',  with: 'The answer for that question does not exist.'
    click_button 'Publish'

    expect(page).to have_content 'Post was successfully created.'
  end

  scenario 'without title input' do
    fill_in 'Body', with: 'The answer for that question does not exist.'
    click_button 'Publish'

    expect(page).to have_content "Title can't be blank"
  end

  scenario 'without body input' do
    fill_in 'Title', with: 'How to be happy?'
    click_button 'Publish'

    expect(page).to have_content "Body can't be blank"
  end
end
