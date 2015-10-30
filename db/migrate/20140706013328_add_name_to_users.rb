class AddNameToUsers < ActiveRecord::Migration
  def up
    add_column :users, :name, :string, null: true

    User.reset_column_information
    User.find_each { |user| user.update_column :name, user.email }

    change_column_null :users, :name, false
  end

  def down
    remove_column :users, :name
  end
end
