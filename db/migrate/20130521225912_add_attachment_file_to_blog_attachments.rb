class AddAttachmentFileToBlogAttachments < ActiveRecord::Migration
  def self.up
    change_table :blog_attachments do |t|
      t.attachment :file
    end
    add_index :blog_attachments, :blog_post_id
  end

  def self.down
    drop_attached_file :blog_attachments, :file
    remove_index :blog_attachments, :blog_post_id
  end
end
