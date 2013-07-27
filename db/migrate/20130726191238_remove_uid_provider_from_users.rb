class RemoveUidProviderFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :uid
    remove_column :users, :provider
  end

  def down
  end
end
