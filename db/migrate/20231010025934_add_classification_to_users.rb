class AddClassificationToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :classification, foreign_key: true
    change_column_default :users, :classification_id, 1
  end
end
