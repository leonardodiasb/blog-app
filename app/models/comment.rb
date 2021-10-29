class Comment < ApplicationRecord
  def update_comments_counter
    pst = Post.find_by(id: posts_id)
    comment_count = Comment.where(posts_id: pst.id).count
    pst.update(comments_counter: comment_count)
  end
end
