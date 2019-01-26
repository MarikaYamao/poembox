class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                  format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                  uniqueness: { case_sensitive: false }
  has_secure_password
  has_one_attached :image
  validates :note, length: { maximum: 300 }
  
  has_many :photos, dependent: :destroy
  has_many :poems, dependent: :destroy
  has_many :likes
  
  has_many :follows
  has_many :followings, through: :follows, source: :follow 
  has_many :reverses_of_like, class_name: 'Follow', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_like, source: :user
  
  def follow(other_user)
    unless self == other_user
      self.follows.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    follows = self.follows.find_by(follow_id: other_user.id)
    follows.destroy if follows
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
  
end

