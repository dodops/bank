class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.monetize :balance

      t.timestamps
    end
  end
end
