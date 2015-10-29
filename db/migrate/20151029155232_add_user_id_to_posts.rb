class AddUserIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :user_id, :integer
    Post.find_each do |p|
      p.update(user_id: 1)
    end
    change_column :posts, :user_id, :integer, null: false
  end
end
