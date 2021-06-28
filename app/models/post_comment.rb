class PostComment < ApplicationRecord
    belongs_to :post_user, optional: true
    belongs_to :post
    validates :comment, presence: true
end
