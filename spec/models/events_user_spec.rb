# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventsUser, type: :model do
  it 'is valid with valid attributes' do
    user = User.create(first_name: 'John', last_name: 'Doe', email: 'test2882@example.com', isAdmin: false,
                       password: 'password')
    event = Event.create(name: 'Event 1', date: Date.today)

    events_user = EventsUser.new(user:, event:)

    expect(events_user).to be_valid
  end

  it 'is not valid without a user_id' do
    Event.create(name: 'Event 1', date: Date.today)
    events_user = EventsUser.new(user_id: nil, event_id: 1)
    expect(events_user).not_to be_valid
  end
end
