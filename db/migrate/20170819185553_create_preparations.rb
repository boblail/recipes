class CreatePreparations < ActiveRecord::Migration[5.1]
  def change
    create_table :preparations do |t|
      t.belongs_to :recipe, null: false, foreign_key: { on_delete: :cascade }
      t.belongs_to :prepared_by, null: false, foreign_key: { to_table: "users" }
      t.date :prepared_on, null: false
      t.text :comments, null: false, default: ""

      t.timestamps
    end

    add_column :recipes, :new_recipe, :boolean, null: false, default: true
    add_column :recipes, :last_prepared_on, :date
  end
end
