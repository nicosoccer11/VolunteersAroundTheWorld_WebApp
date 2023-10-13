require 'rails_helper'

RSpec.describe Classification, type: :model do
  it "has a name attribute" do
    classification = Classification.new(name: "Freshman")
    expect(classification.name).to eq("Freshman")
  end

  it "has many users" do
    association = Classification.reflect_on_association(:users)
    expect(association.macro).to eq :has_many
  end
end