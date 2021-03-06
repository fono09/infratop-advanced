class BookComment < ApplicationRecord
  belongs_to :user
  belongs_to :book
  validates :body, presence: true
  validates :book_id, presence: true
  validates :user_id, presence: true
end
