class AddHasCountdownToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :hasCountdown, :boolean
  end

  def down
    remove_column :events, :hasCountdown, :boolean
  end
end
