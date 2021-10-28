class AddTitleTextCommentsCounterLikesCounterToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :title, :string,
    add_column :posts, :text, :text,
    add_column :posts, :comments_counter, :int,
    add_column :posts, :likes_counter, :int
  end
end
