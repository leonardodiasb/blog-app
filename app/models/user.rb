class User < ApplicationRecord
  has_many :posts, foreign_key: 'author_id', class_name: 'Post'
  has_many :comments, foreign_key: 'author_id', class_name: 'Comment'
  has_many :likes, foreign_key: 'author_id', class_name: 'Like'

  def return_recent_posts
    Post.where(author_id: id).order(created_at: :DESC).limit(3)
  end
end
