class AddPublishedToBlogPosts < ActiveRecord::Migration
  def change
    add_column :blog_posts, :published, :boolean, :null => false, :default => true
    add_index :blog_posts, :published
  end
end
