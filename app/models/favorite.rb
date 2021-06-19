class Favorite < ApplicationRecord
    belongs_to :post_user
    belongs_to :post
end
