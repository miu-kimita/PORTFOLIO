class Favorite < ApplicationRecord
    belongs_to :post_user, optional: true
    belongs_to :post
end
