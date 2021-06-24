class PostComment < ApplicationRecord
    belongs_to :post_user
    belongs_to :post
    validates :comment, presence: true
end
