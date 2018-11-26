class RemoveRenderedContentFromBlogPosts < ActiveRecord::Migration[5.2]
  def change
    remove_column :blog_posts, :rendered_content, :text
  end
end
