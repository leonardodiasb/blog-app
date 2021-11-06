require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = User.create(name: 'Leonard', photo: 'https://picsum.photos/200',
                        bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc cursus eros euismod,
                         ullamcorper magna vel, pellentesque metus. Sed id cursus lorem.',
                        posts_counter: 1)
    @post = Post.create(author_id: @user.id, title: 'Title 1',
                        text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc cursus eros euismod,
                         ullamcorper magna vel, pellentesque metus. Sed id cursus lorem.',
                        comments_counter: 6, likes_counter: 1)
  end

  it 'name should be present' do
    @user.name = nil
    expect(@user).to_not be_valid
  end

  it 'posts_counter should be greater than zero' do
    expect(@user).to be_valid
  end

  it 'return_recent_posts method should return 1 post' do
    posts = @user.return_recent_posts
    expect(posts.length).to be(1)
  end
end
