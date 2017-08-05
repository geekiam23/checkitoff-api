class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.references :user_id, foreign_key: true
      t.string :name
      t.string :description
      t.string :created_by

      t.timestamps null: false
    end
  end
end
