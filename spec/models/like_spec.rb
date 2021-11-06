require 'rails_helper'

RSpec.describe Like, type: :model do
  before(:each) do
    @user = User.create(name: 'Leonard', photo: 'https://picsum.photos/200',
                        bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc cursus eros euismod,
                         ullamcorper magna vel, pellentesque metus. Sed id cursus lorem.',
                        posts_counter: 1)
    @post = Post.create(author_id: @user.id, title: 'Title 1',
                        text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc cursus eros euismod,
                         ullamcorper magna vel, pellentesque metus. Sed id cursus lorem.',
                        comments_counter: 0, likes_counter: 1)
    @like1 = Like.create(author_id: @user.id, post_id: @post.id)
  end

  it 'update_likes_counter method should update the likes counter of a post' do
    @like2 = Like.create(author_id: @user.id, post_id: @post.id)
    Like.update_likes_counter(@post)
    expect(@post.likes_counter).to be(2)
  end
end
