class CreateAccountUsers < ActiveRecord::Migration
  def change
    create_table :accounts_users, id: false do |t|
      t.belongs_to :account
      t.belongs_to :user
      t.timestamps null: false
    end
  end
end
