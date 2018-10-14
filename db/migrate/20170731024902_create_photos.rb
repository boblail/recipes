class CreatePhotos < ActiveRecord::Migration[4.2]
  def change
    enable_extension "uuid-ossp"

    create_table :photos, id: :uuid do |t|
      t.string :filename, null: false

      t.timestamps
    end

    add_column :recipes, :photo_id, :uuid
  end
end
