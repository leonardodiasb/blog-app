class Post < ApplicationRecord
  def update_posts_counter
    usr = User.find_by(id: users_id)
    post_count = Post.where(users_id: id).count
    usr.update(posts_counter: post_count)
  end

  def return_recent_comments
    Comment.where(posts_id: id).order(created_at: :DESC).limit(5)
  end
end
