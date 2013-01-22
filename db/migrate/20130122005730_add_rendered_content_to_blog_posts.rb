class AddRenderedContentToBlogPosts < ActiveRecord::Migration
  def change
    add_column :blog_posts, :rendered_content, :text
  end
end
