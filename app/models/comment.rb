class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  def self.update_comments_counter(post)
    comment_count = Comment.where(post_id: post.id).count
    post.update(comments_counter: comment_count)
  end
end
