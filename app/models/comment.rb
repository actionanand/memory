class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable, dependent: :destroy
  validates :user_id, presence: true
  default_scope -> {order(updated_at: :desc)}
  validates :body, length: { minimum: 1, maximum: 100 }
end
