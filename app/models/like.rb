class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  def self.update_likes_counter(post)
    like_count = Like.where(post_id: post.id).count
    post.update(likes_counter: like_count)
  end
end
