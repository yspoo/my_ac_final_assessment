class AddUsernameToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :username, :string, null: false, default: "" # default: "" is neccessary in order for migration to work. Otherwise the error "PG::NotNullViolation: ERROR:  column "username" contains null values: ALTER TABLE "users" ADD "username" character varying NOT NULL" will appear.
    add_index :users, :username, unique: true
  end
end
