# frozen_string_literal: true

class User < ApplicationRecord
  belongs_to :classification
  has_many :events_users
  has_many :events, through: :events_users
  has_many :attended_events, through: :events_users, source: :event
  validates :classification, presence: true, on: :update_profile

  devise :omniauthable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, omniauth_providers: [:google_oauth2]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.full_name = auth.info.name
      user.avatar_url = auth.info.image
      user.save(validate: false)  # Save without validation for now
    end
  end
  def is_admin?
    isAdmin
  end

  def self.from_omniauth(auth)
    where(email: auth['info']['email']).first_or_create
  end
end
