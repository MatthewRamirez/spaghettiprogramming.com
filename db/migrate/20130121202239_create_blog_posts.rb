class CreateBlogPosts < ActiveRecord::Migration
  def change
    create_table :blog_posts do |t|
      t.text :title, :null => false
      t.text :body, :null => false
      t.integer :category_id
      t.integer :user_id
      t.timestamps
    end
    execute "alter table blog_posts ALTER COLUMN updated_at set DEFAULT now();"
    execute "alter table blog_posts ALTER COLUMN created_at set DEFAULT now();"
    add_index :blog_posts, :category_id
  end
end
