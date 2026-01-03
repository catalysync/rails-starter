class EnableUuid < ActiveRecord::Migration[8.1]
  def change
    enable_extension "pg_crypto"
  end
end
