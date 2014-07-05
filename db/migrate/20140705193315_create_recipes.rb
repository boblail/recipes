class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name, null: false
      t.text :ingredients, null: false
      t.text :instructions, null: false
      t.string :tags, array: true, default: []
      t.integer :effort, null: true
      t.integer :cost, null: true
      t.integer :healthiness, null: true
      t.integer :bob, null: true
      t.integer :rachel, null: true

      t.timestamps

      t.index :tags, using: "gin"
    end
  end
end
