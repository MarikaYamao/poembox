class Poem < ApplicationRecord
  belongs_to :user
  belongs_to :photo
  
  validates :content, presence: true, length: { maximum: 1000 }
end
