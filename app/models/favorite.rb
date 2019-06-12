class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :photo, optional: true
  belongs_to :poem, optional: true
  
  validates :photo_or_poem, presence: true

  private
    def photo_or_poem
      photo.presence or poem.presence
    end
end