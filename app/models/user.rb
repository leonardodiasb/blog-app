class User < ApplicationRecord
  def return_recent_posts
    Post.where(users_id: self.id).order(created_at: :DESC).limit(3)
  end
end
