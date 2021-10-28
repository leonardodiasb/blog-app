class AddNamePhotoBioPostsCounterToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string
    add_column :users, :photo, :string
    add_column :users, :bio, :text
    add_column :users, :posts_counter, :int
  end
end
