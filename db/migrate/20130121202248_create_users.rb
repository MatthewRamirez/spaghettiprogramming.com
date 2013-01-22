class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :email_address, :null => false
      t.text :identifier_url
      t.text :nick
      t.text :uid
      t.text :provider
      t.timestamps
    end
    execute "alter table users ALTER COLUMN updated_at set DEFAULT now();"
    execute "alter table users ALTER COLUMN created_at set DEFAULT now();"
    add_index :users, :email_address, :unique => true
  end
end
