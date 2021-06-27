class PostUser < ApplicationRecord
  has_many :bookmarks, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  attachment :profile_image, destroy: false
  validates :nickname, length: { minimum: 2, maximum: 20 }
  validates :nickname, presence: true
  validates :introduction, length: { maximum: 50 }

  # def self.from_omniauth(auth)       # snsから取得した、providerとuidを使って、既存ユーザーを検索
  #   sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
  #   # sns認証したことがあればアソシエーションで取得、なければSns_credentialsテーブルにレコード作成

  # # snsのpost_user or post_usersテーブルに対し、SNS認証で取得したメールアドレスが登録済みの場合は、取得 or なければビルド(保存はしない)
  #   post_user = sns.post_user || User.where(email: auth.info.email).first_or_initialize(
  #     nickname: auth.info.nickname,
  #     email: auth.info.email
  #   )
  #   if post_user.persisted?   # post_userが登録済みの場合：そのままログインするため、snsのpost_user_idを更新しとく
  #     sns.post_user = post_user
  #     sns.save
  #   end
  #   { post_user: post_user, sns: sns }   # post_user、snsをハッシュで返す(コントローラーがこれを受け取る)
  # end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      # deviseのuserカラムに name を追加している場合は以下のコメントアウトも追記します
      user.nickname = auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[google_oauth2]


end
