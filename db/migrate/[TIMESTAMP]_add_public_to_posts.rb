class AddPublicToPosts < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :public, :boolean, default: true, null: false
  end
end 