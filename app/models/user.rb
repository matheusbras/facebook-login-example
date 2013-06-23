class User < ActiveRecord::Base
  attr_accessible :email, :name, :access_token, :uid, :provider, :photo_url

  validates :email, :access_token, :name, :uid, presence: true
  validates :email, uniqueness: true

  def self.find_or_create_with_omniauth(auth)
    user = self.find_or_create_by_provider_and_uid(auth.provider, auth.uid)
    user.assign_attributes({ name: auth.info.name, email: auth.info.email, photo_url: auth.info.image, access_token: auth.credentials.token })
    user.save!
    user
  end
end