class AddCreatedAtMonthToBlogPosts < ActiveRecord::Migration
  def change
    add_column :blog_posts, :created_at_month, :integer
    add_index :blog_posts, :created_at_month
  end
end
