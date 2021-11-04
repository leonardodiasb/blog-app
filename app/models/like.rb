class Like < ApplicationRecord
  belongs_to :author, class_name: 'User', dependent: :destroy, foreign_key: 'author_id'
  belongs_to :post, dependent: :destroy, foreign_key: true

  def update_likes_counter
    pst = Post.find_by(id: posts_id)
    like_count = Like.where(posts_id: pst.id).count
    pst.update(likes_counter: like_count)
  end
end
