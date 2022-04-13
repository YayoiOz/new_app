class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.integer :follow_id, foreign_key: true
      t.integer :target_id, foreign_key: true

      t.timestamps
      
    end
  end
end
