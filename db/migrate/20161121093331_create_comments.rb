class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.integer :commentable_id, index: true
      t.string :commentable_type
      t.string :commentator_name

      t.timestamps null: false
    end
  end
end
