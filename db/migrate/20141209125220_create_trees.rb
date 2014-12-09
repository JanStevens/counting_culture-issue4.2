class CreateTrees < ActiveRecord::Migration
  def change
    create_table :trees do |t|
      t.string :name
      t.string :leaf_count
      t.timestamps null: false
    end
  end
end
