class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]

  has_many :notes, dependent: :destroy
  has_many :active_relationships,  class_name:   "Relationship",
                                   foreign_key:  "follower_id",
                                   dependent:    :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :passive_relationships,  class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  def feed
    following_ids = "SELECT followed_id FROM relationships  WHERE   follower_id = :user_id"
    Note.where("user_id IN (#{following_ids})  OR  user_id = :user_id", user_id: id)
  end

  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)  # current user follows the user he wants to follow.
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy # current user unfollows the user he wants to unfollow. We do not use follower_id because doing so will destroy all the relationships that current user has with other users as well.
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def is_a_follower_of?(other_user)
    followers.include?(other_user)
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.username = auth.info.name   # assuming the user model has a name
     # user.image = auth.info.image # assuming the user model has an image
     # If you are using confirmable and the provider(s) you use validate emails,
     # uncomment the line below to skip the confirmation emails.
     # user.skip_confirmation!
   end
  end

end
