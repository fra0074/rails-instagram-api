class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
   devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :omniauthable, omniauth_providers: [:instagram]

         # :omniauthable, :omniauth_providers => [:instagram]


  # def self.from_omniauth(auth)
  #     where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  #       user.provider = auth.provider
  #       user.uid = auth.uid
  #       user.password = Devise.friendly_token[0,20]
  #     end
  # end
  #
def self.find_for_instagram_oauth(auth)
    user_params = auth.slice(:provider, :uid)
    # user_params.merge! auth.info.slice(:name, :username)
    user_params[:username] = auth.extra.raw_info.username
    user_params[:name] = auth.info.name
    auth.info.email.nil? ? user_params[:email] = "nomail@test.com" : user_params[:email] = auth.info.email
    user_params[:bio] = auth.info.bio
    user_params[:profile_pic] = auth.info.image
    user_params[:token] = auth.credentials.token
    user_params[:website] = auth.info.website
    # user_params[:token_expiry] = Time.at(auth.credentials.expires_at)
    user_params = user_params.to_h

    user = User.find_by(provider: auth.provider, uid: auth.uid)
    user ||= User.find_by(name: auth.info.name) # User did a regular sign up in the past.
    if user
      user.update(user_params)
    else
      user = User.new(user_params)
      user.password = Devise.friendly_token[0,10]  # Fake password for validation
      user.save
    end

    return user
  end







end
