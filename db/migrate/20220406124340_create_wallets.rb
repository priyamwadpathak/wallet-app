class CreateWallets < ActiveRecord::Migration[6.1]
  def change
    create_table :wallets do |t|
      t.references :user, null: false, foreign_key: true
      t.string :owned_by
      t.boolean :status
      t.datetime :enabled_at
      t.integer :balance

      t.timestamps
    end
  end
end
