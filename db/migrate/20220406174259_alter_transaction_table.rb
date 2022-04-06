class AlterTransactionTable < ActiveRecord::Migration[6.1]
  def change
    remove_column :transactions, :deposited_by
    remove_column :transactions, :deposited_at
    remove_column :transactions, :withdrawn_by
    remove_column :transactions, :withdrawn_at
    add_column :transactions, :by_user, :string
    add_column :transactions, :transaction_at, :datetime
  end
end
