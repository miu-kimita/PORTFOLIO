class PostComment < ApplicationRecord
    belongs_to :post_users
    belongs_to :posts
    validates :comment, presence: true
end
