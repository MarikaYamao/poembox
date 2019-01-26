class Like < ApplicationRecord
  belongs_to :user
  belongs_to :follow, class_name: 'User', optional: true
  belongs_to :photo, optional: true
  belongs_to :poem, optional: true
  
  validates :type,  presence: true
  
end

class Follow < Like
  validates :follow, presence: true
end

class LikePoem < Like
  validates :poem, presence: true
end

class LikePhoto < Like
  validates :photo, presence: true
end