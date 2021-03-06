class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_one_attached :profile_image

  has_many :follower_ids, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :followers, through: :follower_ids, source: :follower

  has_many :follow_ids, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :follows, through: :follow_ids, source: :followed

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  def get_profile_image
    profile_image.attached? ? profile_image : 'no_image.jpg'
  end

  def followed?(user_id)
    followers.where(id: user_id).exists?
  end

  def follows?(user_id)
    follows.where(id: user_id).exists?
  end

  def self.guest
    find_or_create_by!(name: 'guestuser' ,email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end
end
