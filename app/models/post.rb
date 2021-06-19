class Post < ApplicationRecord
	belongs_to :post_user
	has_many :post_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
    has_many :bookmarks, dependent: :destroy
    validates :title, presence: true
    validates :post_detail, presence: true
    validates :post_detail, length: { minimum: 1 }
    attachment :image

    def bookmarked_by?(post_user)
        bookmarks.where(post_user_id: post_user).exists?
    end

    def favorited_by?(post_user)
        favorites.where(post_user_id: post_user.id).exists?
    end

    # def self.search(search, word)
    #     if search == "forward_match"
    #         @post = Post.where("title LIKE?","#{word}%")
    #     elsif search == "backward_match"
    #         @post = Post.where("title LIKE?","%#{word}")
    #     elsif search == "perfect_match"
    #         @post = Post.where(title: "#{word}")
    #     elsif search == "partial_match"
    #         @post = Post.where("title LIKE?","%#{word}%")
    #     else
    #         @post = Post.all
    #     end
    #    上記の物は以前の完全、前方、後方、完全、部分一致の検索に使用した物。wordかsearchか。
    def self.search(search)
        return Post.all unless search
        Post.where('title LIKE(?)', "%#{search}%")
    end
end