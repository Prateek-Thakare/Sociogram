class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]

  mount_uploader :image, ImageUploader
  has_many :posts 
  has_many :likes
  has_many :follwers
  has_many :following
  def full_name
    "#{first_name} #{last_name}"
  end

  def total_followers
    Follower.where(following_id: self.id).count
  end

  def total_following
    Follower.where(follower_id: self.id).count
  end


  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image 
      user.username = auth.info.name.gsub(" ","")# assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end
end
