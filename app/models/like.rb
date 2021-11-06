class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  def update_likes_counter
    pst = Post.find_by(id: post_id)
    like_count = Like.where(post_id: pst.id).count
    pst.update(likes_counter: like_count)
  end
end
