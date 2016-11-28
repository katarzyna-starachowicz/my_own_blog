module Features
  module SessionHelpers
    def sign_up_with(email, username, password)
      visit new_user_registration_path
      fill_in 'Email', with: email
      fill_in 'Username', with: username
      fill_in 'user_password', with: password
      fill_in 'Password confirmation', with: password
      within(".actions") do
        click_on 'Sign up'
      end
    end

    def sign_in_as(user)
      visit new_user_session_path
      fill_in 'Login', with: user.email
      fill_in 'Password', with: user.password
      within(".actions") do
        click_on 'Log in'
      end
    end

    def logout
      click_on 'Log out'
    end
  end
end
