class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  def update_posts_counter
    usr = User.find_by(id: author_id)
    post_count = Post.where(author_id: author_id).count
    usr.update(posts_counter: post_count)
  end

  def return_recent_comments
    Comment.where(post_id: id).order(created_at: :DESC).limit(5)
  end
end
