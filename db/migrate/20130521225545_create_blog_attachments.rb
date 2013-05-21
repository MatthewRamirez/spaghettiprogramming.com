class CreateBlogAttachments < ActiveRecord::Migration
  def change
    create_table :blog_attachments do |t|
      t.references :blog_post

      t.timestamps
    end
  end
end
