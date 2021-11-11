class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :delete_all
  has_many :likes, dependent: :delete_all
  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def self.update_posts_counter(user)
    post_count = Post.where(author_id: user.id).count
    user.update(posts_counter: post_count)
  end

  def return_recent_comments
    Comment.where(post_id: id).order(created_at: :DESC).limit(5)
  end

  def as_json(options={})
    super(:only => [:id, :title, :text, :author_id, :comments_counter, :likes_counter])
  end
end
