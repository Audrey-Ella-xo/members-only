class AddForeignKeyToPosts < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :posts, :users, column: :user_id, primary_key: 'id'
  end
end
