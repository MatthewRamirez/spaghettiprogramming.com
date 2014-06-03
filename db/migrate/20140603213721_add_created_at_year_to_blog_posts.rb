class AddCreatedAtYearToBlogPosts < ActiveRecord::Migration
  def change
    add_column :blog_posts, :created_at_year, :integer
    add_index :blog_posts, :created_at_year
  end
end
