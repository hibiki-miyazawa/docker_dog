class Dog < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, length: { maximum: 50 }
  validates :user_id, presence: true
  validates :gender, inclusion: { in: 1..2 }, allow_blank: true
  validates :type, allow_blank: true, length: { maximum: 25}
  validates :hospital, presence: true
  validates :salon, presence: true
  validates :image_name, presence: true
end
