# user class
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  TEMP_EMAIL_PREFIX = 'change@me'.freeze
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook]
  has_many :contacts, dependent: :destroy
  audited
  validates_uniqueness_of :uid, scope: :provider

  def self.new_with_session(params, session)
    super.tap do |user|
      if data == session['devise.facebook_data'] && session['devise.facebook_data']['extra']['raw_info']
        user.email = data['email'] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    user = where(provider: auth.provider, uid: auth.uid).first
    if user
      user
    else
      email = auth.info.email || "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com"
      User.create(provider: auth.provider, uid: auth.uid, email: email, password: Devise.friendly_token(8))
    end
  end
end
