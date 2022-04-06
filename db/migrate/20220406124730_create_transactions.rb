class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.references :wallet, null: false, foreign_key: true
      t.string :type
      t.string :deposited_by
      t.datetime :deposited_at
      t.string :withdrawn_by
      t.datetime :withdrawn_at
      t.string :status
      t.integer :amount
      t.string :reference_id

      t.timestamps
    end
  end
end
