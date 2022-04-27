class AddReferencesToContents < ActiveRecord::Migration[5.2]
  def change
    add_reference :contents, :tag, foreign_key: true
  end
end
