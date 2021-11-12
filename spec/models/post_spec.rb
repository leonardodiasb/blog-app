require 'rails_helper'

RSpec.describe Post, type: :model do
  before(:each) do
    @user = User.new(name: 'Leonard', photo: 'https://picsum.photos/200',
                     bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc cursus eros euismod,
       ullamcorper magna vel, pellentesque metus. Sed id cursus lorem.',
                     posts_counter: 0, email: 'leonard@leonard.com', password: 'llllll', role: 'admin')
    @user.skip_confirmation!
    @user.save
    @post = Post.create(author_id: @user.id, title: 'Title 1',
                        text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc cursus eros euismod,
                         ullamcorper magna vel, pellentesque metus. Sed id cursus lorem.',
                        comments_counter: 6, likes_counter: 1)
    @comment1 = Comment.create(author_id: @user.id, post_id: @post.id, text: 'Comment 1')
    @comment2 = Comment.create(author_id: @user.id, post_id: @post.id, text: 'Comment 2')
    @comment3 = Comment.create(author_id: @user.id, post_id: @post.id, text: 'Comment 3')
    @comment4 = Comment.create(author_id: @user.id, post_id: @post.id, text: 'Comment 4')
    @comment5 = Comment.create(author_id: @user.id, post_id: @post.id, text: 'Comment 5')
    @comment6 = Comment.create(author_id: @user.id, post_id: @post.id, text: 'Comment 6')
    @like = Like.create(author_id: @user.id, post_id: @post.id)
  end

  it 'name has a valid length' do
    @post.title = 't' * 251
    expect(@post).to_not be_valid
  end

  it 'comments_counter is greater than 0' do
    expect(@post).to be_valid
  end

  it 'likes_counter is greater than 0' do
    expect(@post).to be_valid
  end

  it 'update_post_counter method should update posts_counter for a user' do
    Post.update_posts_counter(@user)
    expect(@user.posts_counter).to be(1)
  end

  it 'most_recent_comments return last 5 comments' do
    comments = @post.return_recent_comments
    expect(comments.length).to be(5)
  end
end
