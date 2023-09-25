class User < ApplicationRecord
  has_many :events_users
  has_many :events, through: :events_users
  
  devise :omniauthable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, omniauth_providers: [:google_oauth2]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.full_name = auth.info.name # assuming the user model has a name
      user.avatar_url = auth.info.image # assuming the user model has an image
    end
  end
  
  def is_admin?
    self.isAdmin
  end

  def self.from_omniauth(auth)
    where(email: auth["info"]["email"]).first_or_create
  end
end
