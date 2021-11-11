require 'rails_helper'

RSpec.describe 'Login Page', type: :feature do
  describe 'test:' do
    before :all do
      test_user = User.new(name: 'John Doe', email: 'random@test.com', password: '123456', role: 'user')
      test_user.skip_confirmation!
      test_user.save
    end

    it 'shows the email, password and log in button' do
      visit '/users/sign_in/'
      expect(page).to have_field('user_email')
      expect(page).to have_field('user_password')
      expect(page).to have_content('Log in')
      expect(page).to have_css('input', count: 4)
    end

    it 'shows an error when clicking "Log in" without filling the fields' do
      visit '/users/sign_in/'
      click_on 'Log in'
      expect(page).to have_content('Invalid Email or password.')
    end

    it 'shows an error when clicking "Log in" and the fields contain wrong data' do
      visit '/users/sign_in/'
      fill_in 'Email', with: 'testuser@test.com'
      fill_in 'Password', with: '123456789'
      click_on 'Log in'
      expect(page).to have_content('Invalid Email or password.')
    end

    it 'renders the root page when logging in' do
      visit '/users/sign_in/'
      fill_in 'Email', with: 'random@test.com'
      fill_in 'Password', with: '123456'
      click_on 'Log in'
      expect(page).to have_content('Signed in successfully.')
      expect(current_path).to eq(root_path)
    end
  end
end
