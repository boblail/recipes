class AddFamilyMembersToUsers < ActiveRecord::Migration
  def change
    add_column :users, :family_members, :string, array: true, default: []
  end
end
