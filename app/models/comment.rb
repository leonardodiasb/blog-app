class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User', dependent: :destroy, foreign_key: 'author_id'
  belongs_to :post, dependent: :destroy, foreign_key: true

  def update_comments_counter
    pst = Post.find_by(id: posts_id)
    comment_count = Comment.where(posts_id: pst.id).count
    pst.update(comments_counter: comment_count)
  end
end
