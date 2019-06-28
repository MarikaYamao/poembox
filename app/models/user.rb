class User < ApplicationRecord
  attr_accessor :remember_token
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                  format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                  uniqueness: { case_sensitive: false }
  has_secure_password
  has_one_attached :image
  validates :note, length: { maximum: 255 }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validates :image, content_type: ['image/png', 'image/jpg', 'image/jpeg'], allow_nil: true
  validates :locale, inclusion: { in: %w(ja en) }
  validates :time_zone, inclusion: { in: ActiveSupport::TimeZone::MAPPING.keys }
  
  
  has_many :photos, dependent: :destroy
  has_many :poems, dependent: :destroy
  
  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user
  
  has_many :favorites, dependent: :destroy
  has_many :like_photos
  has_many :favorites_photo, through: :like_photos, source: :photo
  has_many :like_poems
  has_many :favorites_poem, through: :like_poems, source: :poem
  
  # フォロー
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  # いいね Photo
  def like_photo(photo)
    self.like_photos.find_or_create_by(photo_id: photo.id)
  end
  
  def unlike_photo(photo)
    like = self.like_photos.find_by(photo_id: photo.id)
    like.destroy if like_photos
  end
  
  def liked_photo?(photo)
    self.favorites_photo.include?(photo)
  end
  
  # いいね Poem
  def like_poem(poem)
    self.like_poems.find_or_create_by(poem_id: poem.id)
  end
  
  def unlike_poem(poem)
    like = self.like_poems.find_by(poem_id: poem.id)
    like.destroy if like_poems
  end
  
  def liked_poem?(poem)
    self.favorites_poem.include?(poem)
  end
  
  # タイムライン
  def feed_photos
    Photo.where( user_id: self.following_ids + [ self.id ] )
  end
  
  def feed_poems
    Poem.where( user_id: self.following_ids + [ self.id ] )
  end

  # パスワード・トークン
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  def forgot
    update_attribute(:remember_digest, nil)
  end
end

