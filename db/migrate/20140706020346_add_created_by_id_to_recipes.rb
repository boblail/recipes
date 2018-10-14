class AddCreatedByIdToRecipes < ActiveRecord::Migration[4.2]
  def up
    add_column :recipes, :created_by_id, :integer

    if Recipe.count > 0
      Recipe.reset_column_information
      Recipe.update_all created_by_id: User.first.id
    end

    change_column_null :recipes, :created_by_id, false
  end

  def down
    remove_column :recipes, :created_by_id
  end
end
