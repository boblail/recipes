class CreateMenuPlans < ActiveRecord::Migration[5.1]
  def up
    create_table :menu_plans do |t|
      t.belongs_to :cookbook, null: false, foreign_key: { to_table: :cookbooks, on_delete: :cascade }, index: true
      t.string :name, null: false
    end

    add_column :cookbooks, :current_menu_plan_id, :integer

    Cookbook.find_each do |cookbook|
      cookbook.send :create_first_menu_plan!
    end

    # TODO: make cookbooks.current_menu_plan_id NOT NULL — but defer the constraint
    #       so that it is only evaluated at the end of a transaction so that
    #       we can get the cookbook into the database before we create the first
    #       menu plan that belongs to it. This is probably a Postgres-only feature
    #       and we should switch from schema.rb to structure.sql

    add_foreign_key :cookbooks, :menu_plans, column: :current_menu_plan_id
  end

  def down
    remove_column :cookbooks, :current_menu_plan_id
    drop_table :menu_plans
  end
end
