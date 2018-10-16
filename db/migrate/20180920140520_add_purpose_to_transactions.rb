class AddPurposeToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :purpose, :string
  end
end
