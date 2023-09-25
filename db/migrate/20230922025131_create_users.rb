class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      # Removed t.string :id
      t.string :first_name
      t.string :last_name
      t.string :email
      t.boolean :isAdmin, default: false 

      t.timestamps
    end
  end
end
