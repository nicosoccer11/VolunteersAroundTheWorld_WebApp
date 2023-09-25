class Event < ApplicationRecord
    has_many :events_users
    has_many :users, through: :events_users
    validates :name, presence: true
    validates :date, presence: true
  end