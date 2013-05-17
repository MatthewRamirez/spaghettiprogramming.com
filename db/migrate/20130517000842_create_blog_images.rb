class CreateBlogImages < ActiveRecord::Migration
  def change
    create_table :blog_images do |t|
      t.references :blog_post

      t.timestamps
    end
    add_index :blog_images, :blog_post_id
  end
end
