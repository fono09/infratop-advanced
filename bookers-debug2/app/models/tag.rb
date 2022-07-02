class Tag < ApplicationRecord
  has_many :books

  validates :tag_name, presence: true, uniqueness: true
end
