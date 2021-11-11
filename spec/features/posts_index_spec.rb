require 'rails_helper'

RSpec.describe 'Post Index Page', type: :feature do
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

      test_post1 = Post.create(title: 'Post 1', text: 'Text 1', author_id: test_user.id, comments_counter: 0,
                               likes_counter: 0)
      Post.create(title: 'Post 2', text: 'Text 2', author_id: test_user.id, comments_counter: 0, likes_counter: 0)
      Post.create(title: 'Post 3', text: 'Text 3', author_id: test_user.id, comments_counter: 0, likes_counter: 0)

      Comment.create(text: 'Comment 1', post_id: test_post1.id, author_id: test_user.id)
      Comment.create(text: 'Comment 2', post_id: test_post1.id, author_id: test_user.id)
      Comment.create(text: 'Comment 3', post_id: test_post1.id, author_id: test_user.id)
      Like.create(post_id: test_post1.id, author_id: test_user.id)

      Post.update_posts_counter(test_user)
      Comment.update_comments_counter(test_post1)
      Like.update_likes_counter(test_post1)
      visit '/users/sign_in/'
      fill_in 'Email', with: 'user1@test.com'
      fill_in 'Password', with: '123456'
      click_on 'Log in'
      visit "/users/#{test_user.id}/posts/"
    end

    it 'I can see the user profile picture.' do
      expect(page).to have_selector('img', count: 1)
    end

    it 'I can see the user username.' do
      expect(page).to have_content('User 1')
    end

    it 'I can see the number of posts the user has written.' do
      expect(page).to have_content('Number of posts: 3')
    end

    it 'I can see a post title.' do
      expect(page).to have_content('Post 1')
    end

    it 'I can see some of the post body.' do
      expect(page).to have_content('Text 1')
    end

    it 'I can see the first comments on a post.' do
      expect(page).to have_content('Comment 1')
    end

    it 'I can see how many comments a post has.' do
      expect(page).to have_content('Comments: 3')
    end

    it 'I can see how many likes a post has.' do
      expect(page).to have_content('Likes: 1')
    end

    it 'When I click on a post, it redirects me to that post show page.' do
      find('a', text: 'Post 1').click
      expect(page).to have_content('Post 1')
    end
  end
end
