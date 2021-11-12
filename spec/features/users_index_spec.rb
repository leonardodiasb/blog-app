require 'rails_helper'

RSpec.describe 'User Index Page', type: :feature do
  describe 'test:' do
    before :each do
      test_user = User.new(name: 'User 1', email: 'user1@test.com', password: '123456', role: 'user')
      test_user.skip_confirmation!
      test_user.bio = 'Demo bio'
      test_user.save

      test_user2 = User.new(name: 'User 2', email: 'user2@test.com', password: '123456', role: 'user')
      test_user2.skip_confirmation!
      test_user2.bio = 'Demo bio'
      test_user2.save

      Post.create(title: 'Post 1', text: 'Text 1', author_id: test_user.id, comments_counter: 0, likes_counter: 0)
      Post.update_posts_counter(test_user)

      visit '/users/sign_in/'
      fill_in 'Email', with: 'user1@test.com'
      fill_in 'Password', with: '123456'
      click_on 'Log in'
    end

    it 'I can see the username of all other users.' do
      expect(page).to have_content('User 1')
      expect(page).to have_content('User 2')
    end

    it 'I can see the profile picture for each user.' do
      expect(page).to have_selector('img', minimum: 2)
    end

    it 'I can see the number of posts each user has written.' do
      expect(page).to have_content('Number of posts: 1')
      expect(page).to have_content('Number of posts: 0')
    end

    it "When I click on a user, I am redirected to that user's show page." do
      click_on 'User 1'
      test_user = User.find_by(name: 'User 1')
      expect(page).to have_content('Bio')
      expect(page).to have_content('Number of posts: 1')
      expect(page).to have_content('Add Post')
      expect(page).to have_content('See All Posts')
      expect(current_path).to eq("/users/#{test_user.id}")
    end
  end
end
