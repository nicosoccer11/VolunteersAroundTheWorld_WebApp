# frozen_string_literal: true

class Event < ApplicationRecord
  has_many :events_users
  has_many :users, through: :events_users
  validates :name, presence: true
  validates :date, presence: true
  # attr_accessible :start_time
end
