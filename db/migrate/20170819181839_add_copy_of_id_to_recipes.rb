class AddCopyOfIdToRecipes < ActiveRecord::Migration[5.1]
  def change
    add_reference :recipes, :copy_of, foreign_key: { to_table: "recipes", on_delete: :nullify }, null: true
  end
end
