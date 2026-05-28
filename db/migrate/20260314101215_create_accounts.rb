class CreateAccounts < ActiveRecord::Migration[8.1]
  def change
    create_table :accounts, id: :uuid do |t|
      t.string :name, null: false
      t.boolean :personal, default: false, null: false
      t.references :owner, type: :uuid, foreign_key: { to_table: :users }, null: false
      t.string :subdomain
      t.string :custom_domain
      t.string :billing_email
      t.string :stripe_customer_id
      t.jsonb :settings, default: {}
      t.jsonb :metadata, default: {}
      t.timestamps
    end

    add_index :accounts, :subdomain, unique: true, where: "subdomain IS NOT NULL"
    add_index :accounts, :custom_domain, unique: true, where: "custom_domain IS NOT NULL"
    add_index :accounts, :stripe_customer_id, unique: true, where: "stripe_customer_id IS NOT NULL"
  end
end
