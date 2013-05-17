class AddAttachmentImageToBlogImages < ActiveRecord::Migration
  def self.up
    change_table :blog_images do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :blog_images, :image
  end
end
