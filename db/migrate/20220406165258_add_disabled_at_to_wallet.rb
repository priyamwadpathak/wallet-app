class AddDisabledAtToWallet < ActiveRecord::Migration[6.1]
  def change
    add_column :wallets, :disabled_at, :datetime
  end
end
