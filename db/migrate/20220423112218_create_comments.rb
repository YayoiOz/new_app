class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :user_id, foreign_key: true
      t.integer :content_id, foreign_key: true
      t.string :combody

      t.timestamps
    end
  end
end
