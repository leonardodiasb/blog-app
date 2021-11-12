require 'rails_helper'

RSpec.describe Comment, type: :model do
  before(:each) do
    @user = User.new(name: 'Leonard', photo: 'https://picsum.photos/200',
                     bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc cursus eros euismod,
       ullamcorper magna vel, pellentesque metus. Sed id cursus lorem.',
                     posts_counter: 1, email: 'leonard@leonard.com', password: 'llllll', role: 'admin')
    @user.skip_confirmation!
    @user.save
    @post = Post.create(author_id: @user.id, title: 'Title 1',
                        text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc cursus eros euismod,
                         ullamcorper magna vel, pellentesque metus. Sed id cursus lorem.',
                        comments_counter: 1, likes_counter: 0)
    @comment1 = Comment.create(author_id: @user.id, post_id: @post.id, text: 'Comment 1')
  end

  it 'create comment should create a new comment' do
    @comment2 = Comment.create(author_id: @user.id, post_id: @post.id, text: 'Comment 2')
    expect(@comment2.text).to eq('Comment 2')
  end

  it 'update_comments_counter method should update the comments counter of a post' do
    @comment2 = Comment.create(author_id: @user.id, post_id: @post.id, text: 'Comment 2')
    Comment.update_comments_counter(@post)
    expect(@post.comments_counter).to be(2)
  end
end
