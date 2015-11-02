class AddPasswordDigestToUsers < ActiveRecord::Migration
  def change
    add_column :users, :password_digest, :string
    User.find_each do |u|
      u.password = u[:password]
      u.password_confirmation = u.password
      u.save!
    end
    remove_column :users, :password, :string
  end
end
