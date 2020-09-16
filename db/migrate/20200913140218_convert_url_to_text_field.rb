class ConvertUrlToTextField < ActiveRecord::Migration[5.2]
  def up
    change_column :recipes, :source, :text
  end

  def down
    change_column :recipes, :source, :text
  end
end
