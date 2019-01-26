class Photo < ApplicationRecord
  belongs_to :user
  has_one_attached :image_name
  
  validates :image_name, presence: true
  
  has_many :poems, dependent: :destroy
end
