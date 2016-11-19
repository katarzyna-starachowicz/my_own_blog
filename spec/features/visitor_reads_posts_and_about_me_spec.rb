require 'rails_helper'

feature 'Visitor reads posts and about me' do
  let!(:post) { create(:post) }

  before { visit root_path }

  scenario 'all posts page' do
    expect(page).to have_css 'header p', text: 'All posts'
  end

  scenario 'single post page' do
    click_on post.title

    expect(page).to have_content post.body
    expect(page).to have_content 'published:'

    expect(page).not_to have_content 'Delete'
    expect(page).not_to have_content 'Edit'
  end

  scenario 'can back to all posts from single post page' do
    click_on post.title
    click_on 'Back to all posts'

    expect(page).to have_css 'header p', text: 'All posts'
  end

  scenario 'about me page' do
    click_on 'About me'

    expect(page).to have_css     'header p', text: 'About me'
    expect(page).to have_content 'Katarzyna'
  end

  scenario 'should see Sign up' do
    expect(page).to have_content 'Sign up'
  end

  scenario 'should see Log in' do
    expect(page).to have_content 'Log in'
  end
end
