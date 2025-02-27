class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :content, presence: true, length: { minimum: 1, maximum: 1000 }
  validates :user_id, presence: true
  validates :public, inclusion: { in: [true, false] }
  
  scope :public_posts, -> { where(public: true) }
  scope :private_posts, -> { where(public: false) }
  scope :recent, -> { order(created_at: :desc) }

  attribute :public, :boolean, default: true

  private
end

# dependent: :destroy: This option ensures that when a Post is deleted, 
# all of its associated comments are also deleted from the database. 