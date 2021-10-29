class Comment < ApplicationRecord
  def update_comments_counter
    pst = Post.find_by(id: self.id)
    comment_count = Comment.where(posts_id: self.id).count
    pst.update(comments_counter: comment_count)
  end
end
