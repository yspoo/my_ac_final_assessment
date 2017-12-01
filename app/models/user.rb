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

  has_many :likes, dependent: :destroy
  has_many :liked, class_name: "Note", through: :likes, source: :note, dependent: :destroy   # user.liked will return all the notes that the user liked. source: :note refers to the note_id column. source always refer to a column in the model and its value is always a column that represents ID.

  def feed
    following_ids = "SELECT   followed_id   FROM    relationships  WHERE   follower_id = :user_id"
    Note.where("user_id   IN    (#{following_ids})    OR    user_id = :user_id", user_id: id)
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

  def liked?(note)
    liked.include?(note)
  end

  # def like(note)
  #   liked << note unless self.liked?(note)
  # end
  #
  # def liked?(note)
  #   liked.include?(note)
  # end
  #
  # def unlike(note)
  #   liked.delete(note)
  # end

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
