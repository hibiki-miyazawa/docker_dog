class Dog < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, length: { maximum: 50 }
  validates :user_id, presence: true
  validates :breed, allow_blank: true, length: { maximum: 25}
  validates :hospital, presence: true
  validates :salon, presence: true
  mount_uploader :image_name, ImageUploader
end
