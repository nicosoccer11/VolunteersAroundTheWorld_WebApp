# frozen_string_literal: true

class EventsUser < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :user_id, uniqueness: { scope: :event_id, message: 'User is already checked in for this event.' }
end
