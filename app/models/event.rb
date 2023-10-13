class Event < ApplicationRecord
<<<<<<< HEAD
    has_many :events_users
    has_many :users, through: :events_users
    validates :name, presence: true
    validates :date, presence: true
    validates_inclusion_of :hasCountdown, in: [true, false]
  end
=======
  has_many :events_users
  has_many :users, through: :events_users
  validates :name, presence: true
  validates :date, presence: true
  # attr_accessible :start_time
end
>>>>>>> e0040a09a078848cb075caac909ea8337c3de406
