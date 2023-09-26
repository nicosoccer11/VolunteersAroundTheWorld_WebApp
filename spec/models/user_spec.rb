# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    user = User.new(
      first_name: 'John',
      last_name: 'Doe',
      email: 'john.doe@example.com',
      password: 'password'
    )
    expect(user).to be_valid
  end

  it 'is not valid without an email' do
    user = User.new(email: nil)
    expect(user).not_to be_valid
  end
end
