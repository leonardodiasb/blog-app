class Like < ApplicationRecord
  def update_likes_counter
    pst = Post.find_by(id: posts_id)
    like_count = Like.where(posts_id: pst.id).count
    pst.update(likes_counter: like_count)
  end
end
