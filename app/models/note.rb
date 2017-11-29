class Note < ApplicationRecord

  belongs_to :user

  validates :note_id, presence: true

end
