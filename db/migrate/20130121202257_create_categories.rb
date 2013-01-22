class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.text :name, :null => false
      t.timestamps
    end
    execute "alter table categories ALTER COLUMN updated_at set DEFAULT now();"
    execute "alter table categories ALTER COLUMN created_at set DEFAULT now();"
    add_index :categories, :name, :unique => true
  end
end
