class Photo < ApplicationRecord
  belongs_to :user
  has_one_attached :image_name
  default_scope -> { order(created_at: :desc) }

  validate :validate_image
  
  has_many :poems, dependent: :destroy

  def thumbnail input
    return self.image_name[input].variant(resize: '500x500!').processed
  end

  def validate_image
    if !image_name.attached?
      errors.add(:image_name, 'Please select an image.')
    elsif !image_name.content_type.in?(%("image/jpg image/jpeg image/png"))
      errors.add(:image_name, 'Please post in JPEG or PNG.')
    end
  end
end
