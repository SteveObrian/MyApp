class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.references :user, foreign_key: true
      t.decimal :balance, precision: 8, scale: 2, default: 0.00
      t.string :account_name

      t.timestamps
    end
  end
end
