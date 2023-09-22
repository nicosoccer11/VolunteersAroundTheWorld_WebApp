class CreateEventsUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :events_users, id: false do |t|
      t.references :event, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
    end

    add_index :events_users, [:event_id, :user_id], unique: true
  end
end