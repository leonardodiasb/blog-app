class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  def update_comments_counter
    pst = Post.find_by(id: post_id)
    comment_count = Comment.where(post_id: pst.id).count
    pst.update(comments_counter: comment_count)
  end
end
