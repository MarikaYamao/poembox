class Poem < ApplicationRecord
  belongs_to :user
  belongs_to :photo
  default_scope -> { order(created_at: :desc) }

  validates :title, presence: true, length: { maximum: 80 }
  validates :content, presence: true, length: { maximum: 2000 }
  
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites
  has_many :like_poems, dependent: :destroy
  has_many :favorites_poem, through: :like_poems, source: :user
end
