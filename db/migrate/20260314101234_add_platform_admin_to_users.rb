class AddPlatformAdminToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :platform_admin, :boolean, default: false, null: false
  end
end
