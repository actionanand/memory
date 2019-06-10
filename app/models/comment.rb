class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable, dependent: :destroy
  validates :user_id, presence: true
  validates :body, length: { minimum: 3, maximum: 100 }
end
