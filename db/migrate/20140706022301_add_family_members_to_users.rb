class AddFamilyMembersToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :family_members, :string, array: true, default: []
  end
end
