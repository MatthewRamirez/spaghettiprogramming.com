class AddSlugToBlogPosts < ActiveRecord::Migration
  def change
    add_column :blog_posts, :slug, :text
    add_index :blog_posts, :slug
  end
end
