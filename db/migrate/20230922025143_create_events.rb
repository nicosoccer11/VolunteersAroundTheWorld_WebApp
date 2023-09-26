# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      # Removed t.string :id
      t.string :name
      t.date :date

      t.timestamps
    end
  end
end
