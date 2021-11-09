class CreateUser < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :photo
      t.text :bio
      t.integer :posts_counter, :default => 0
      t.string :role

      t.timestamps
    end
  end
end
