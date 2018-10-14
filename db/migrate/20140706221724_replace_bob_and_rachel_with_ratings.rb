class ReplaceBobAndRachelWithRatings < ActiveRecord::Migration[4.2]
  def up
    remove_column :recipes, :bob
    remove_column :recipes, :rachel

    create_table :ratings do |t|
      t.references :recipe
      t.references :user
      t.string :name, null: false
      t.integer :value, null: false

      t.timestamps

      t.index [:recipe_id, :user_id]
    end
  end

  def down
    drop_table :ratings

    add_column :recipes, :bob, :integer
    add_column :recipes, :rachel, :integer
  end
end
