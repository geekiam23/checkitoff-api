class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :title
      t.string :description
      t.string :created_by

      t.timestamps null: false
    end
  end
end
