require 'rails_helper'

RSpec.describe Event, type: :model do
  it 'is valid with valid attributes' do
    event = Event.new(name: 'Event 1', date: Date.today)
    expect(event).to be_valid
  end

  it 'is not valid without a name' do
    event = Event.new(date: Date.today)
    expect(event).not_to be_valid
  end

  it 'is not valid without a date' do
    event = Event.new(name: 'Event 1')
    expect(event).not_to be_valid
  end
end
