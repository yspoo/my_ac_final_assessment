class AddAvatarUrlToUsers < ActiveRecord::Migration[5.1]
  def change
    add column :users, :avatar_url, :string
  end
end
