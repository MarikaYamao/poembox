class Poem < ApplicationRecord
  belongs_to :user
  belongs_to :photo
  default_scope -> { order(created_at: :desc) }

  validates :content, presence: true, length: { maximum: 2000 }
  
  has_many :favorites
  has_many :users, through: :favorites
  has_many :like_poems
  has_many :favorites_poem, through: :like_poems, source: :user
end
