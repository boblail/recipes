class CreateTags < ActiveRecord::Migration[5.1]
  def up
    create_table :tags do |t|
      t.belongs_to :cookbook, null: false, foreign_key: { on_delete: :cascade }
      t.string :name, null: false

      t.index [:cookbook_id, :name], unique: true
    end

    create_join_table :recipes, :tags do |t|
      t.index [:recipe_id, :tag_id], unique: true
    end

    Cookbook.find_each do |cookbook|
      names = cookbook.recipes.pluck(:tags).flatten.uniq
      tags = cookbook.tags.create!(names.map { |name| { name: name } })
      tag_id_by_name = tags.each_with_object({}) { |tag, map| map[tag.name] = tag.id }

      cookbook.recipes.find_each do |recipe|
        recipe.tag_ids = tag_id_by_name.values_at(*recipe.read_attribute(:tags))
      end
    end
  end

  def down
    drop_table :tags
    drop_join_table :recipes, :tags
  end
end
