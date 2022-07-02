class Book < ApplicationRecord
  RATING_MAX_VALUE = 5

  belongs_to :user
  has_many :favorites
  has_many :book_comments
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }
  validates :rating, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: Book::RATING_MAX_VALUE }


  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
