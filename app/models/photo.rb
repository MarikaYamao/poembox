class Photo < ApplicationRecord
  belongs_to :user
  has_one_attached :image_name
  default_scope -> { order(created_at: :desc) }

  validate :validate_image
  
  has_many :poems, dependent: :destroy
  
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites
  has_many :like_photos, dependent: :destroy
  has_many :favorites_photo, through: :like_photos, source: :user

  def validate_image
    if !image_name.attached?
      errors.add(:base, :none)
    elsif !image_name.content_type.in?(%("image/jpg image/jpeg image/png"))
      errors.add(:base, :type)
    end
  end
end
