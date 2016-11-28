require 'rails_helper'

feature 'Visitor signs up' do
  let(:email)    { 'test@email.com' }
  let(:name)     { 'nick_name' }
  let(:password) { 'password' }
  let(:user)     { create(:user) }

  scenario 'with valid email, name and password' do
    sign_up_with email, name, password
    expect(page).to have_content('Log out')
  end

  scenario 'with invalid email' do
    sign_up_with 'invalid_email', name, password
    expect(page).to have_content('is invalid')
  end

  scenario 'with already taken email' do
    sign_up_with user.email, name, password
    expect(page).to have_content('has already been taken')
  end

  scenario 'with blank email' do
    sign_up_with '', name, password
    expect(page).to have_content("can't be blank")
  end

  scenario 'with invalid name' do
    sign_up_with '@', name, password
    expect(page).to have_content('is invalid')
  end

  scenario 'with already taken name' do
    sign_up_with user.email, name, password
    expect(page).to have_content('has already been taken')
  end

  scenario 'with blank name' do
    sign_up_with email, '', password
    expect(page).to have_content("can't be blank")
  end

  scenario 'with blank password' do
    sign_up_with email, name,  ''
    expect(page).to have_content("can't be blank")
  end
end
