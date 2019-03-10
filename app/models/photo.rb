class Photo < ApplicationRecord
  belongs_to :user
  has_one_attached :image_name
  
  validate :validate_image
  
  has_many :poems, dependent: :destroy

  def validate_image
    if !image_name.attached?
      errors.add(:image_name, '画像を選択してください。')
    elsif !image_name.content_type.in?(%("image/jpeg image/png"))
      errors.add(:image_name, 'JPEG または PNG で投稿してください。')
    elsif image_name.byte_size > 5.megabytes
      errors.add(:image_name, '10MB以下で投稿してください。')
    end
  end

  def image?
    %w[image/jpg image/jpeg image/png].include?(image_name.blob.content_type)
  end
end
