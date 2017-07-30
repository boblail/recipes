class CreateCookbooks < ActiveRecord::Migration
  def up
    remove_column :users, :family_members

    create_table :cookbooks do |t|
      t.string :name, null: false

      t.timestamps
    end

    # For now, each user will have their own cookbook.
    # There will be a way for users to share a cookbook
    # so that a family can share a collection of recipes.
    # It may or may not make sense for users to have
    # many cookbooks — like a pinterest user has many boards.
    # We'll wait and see.
    add_column :users, :cookbook_id, :integer

    cookbooks_by_user_id = {}
    User.find_each do |user|
      cookbook = Cookbook.create!(name: "#{user.name}'s Recipes")
      user.update_column :cookbook_id, cookbook.id
      cookbooks_by_user_id[user.id] = cookbook
    end

    change_column_null :users, :cookbook_id, false
    add_index :users, :cookbook_id



    # Recipes will belong to only one cookbook. It might be
    # possible to discover other user's recipes on this application,
    # but if you added a recipe from another user's cookbook,
    # you'd get a copy of it — so that you could both independently
    # monkey with the ingredients or instructions.
    add_column :recipes, :cookbook_id, :integer

    Recipe.find_each do |recipe|
      cookbook = cookbooks_by_user_id.fetch(recipe.created_by_id)
      recipe.update_column :cookbook_id, cookbook.id
    end

    change_column_null :recipes, :cookbook_id, false
    add_index :recipes, :cookbook_id
  end

  def down
    remove_column :recipes, :cookbook_id
    remove_column :users, :cookbook_id
    drop_table :cookbooks
    add_column :users, :family_members, :string, array: true, default: []
  end
end
