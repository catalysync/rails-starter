class CreateMemberships < ActiveRecord::Migration[8.1]
  def change
    create_table :memberships, id: :uuid do |t|
      t.references :user, type: :uuid, foreign_key: true, null: false
      t.references :account, type: :uuid, foreign_key: true, null: false
      t.string :role, null: false, default: "member"
      t.string :status, null: false, default: "active"
      t.timestamps
    end

    add_index :memberships, [ :user_id, :account_id ], unique: true
    add_index :memberships, :role
    add_index :memberships, :status
  end
end
