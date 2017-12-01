class Note < ApplicationRecord

  belongs_to :user, optional: true

  has_many :likes, dependent: :destroy
  has_many :likers, class_name: "User", through: :likes, source: :user # note.likers return all the users that liked that particular note.

  validates :title, presence: true
  validates :body, presence: true
  validates :user_id, presence: true

end
