class User < ApplicationRecord
  has_many :events_users
  has_many :events, through: :events_users

  def is_admin?
    self.admin
  end

  def self.from_omniauth(auth)
    where(email: auth["info"]["email"]).first_or_create
  end
end
