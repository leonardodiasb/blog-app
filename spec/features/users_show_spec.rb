require 'rails_helper'

RSpec.describe 'User Show Page', type: :feature do
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
      Post.create(title: 'Post 2', text: 'Text 2', author_id: test_user.id, comments_counter: 0, likes_counter: 0)
      Post.create(title: 'Post 3', text: 'Text 3', author_id: test_user.id, comments_counter: 0, likes_counter: 0)
      Post.update_posts_counter(test_user)

      visit '/users/sign_in/'
      fill_in 'Email', with: 'user1@test.com'
      fill_in 'Password', with: '123456'
      click_on 'Log in'
      visit "/users/#{test_user.id}/"
    end

    it "I can see the user's profile picture." do
      expect(page).to have_selector('img', count: 1)
    end

    it "I can see the user's username." do
      expect(page).to have_content('User 1')
    end

    it 'I can see the number of posts the user has written.' do
      expect(page).to have_content('Number of posts: 3')
    end

    it "I can see the user's bio." do
      expect(page).to have_content('Demo bio')
    end

    it "I can see the user's first 3 posts." do
      expect(page).to have_content('Post 1')
      expect(page).to have_content('Post 2')
      expect(page).to have_content('Post 3')
    end

    it "I can see a button that lets me view all of a user's posts." do
      expect(page).to have_selector('a', text: 'See All Posts')
    end

    it "When I click a user's post, it redirects me to that post's show page." do
      click_on 'Post 1'
      expect(page).to have_content('Post 1')
    end

    it "When I click to see all posts, it redirects me to the user's post's index page." do
      find('a', text: 'See All Posts').click
      expect(page).to have_content('Post 1')
      expect(page).to have_content('Post 2')
      expect(page).to have_content('Post 3')
      expect(page).to have_selector('a', class: 'post_title')
    end
  end
end
