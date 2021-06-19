class Bookmark < ApplicationRecord
  validates :post_user_id, uniqueness: { scope: :post_id }
  belongs_to :post_user
  belongs_to :post

end
