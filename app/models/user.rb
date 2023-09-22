class User < ApplicationRecord
    has_many :events_users
    has_many :events, through: :events_users
  end