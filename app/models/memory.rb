class Memory < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  validates :user_id, presence: true
  validates :title, length: { minimum: 3, maximum: 30 }
  validates :body, length: { minimum: 3, maximum: 1000 }
  acts_as_votable
end
