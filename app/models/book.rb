class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy #BookモデルとBookCommentモデルを関連付け
  scope :most_favorite, -> { left_joins(:favorites).select(:id, "COUNT(favorites.id) AS favorites_count").group(:id) } #お気に入り多い順に並び替え
  has_one_attached :image
  #scope :most_favorited, -> { includes(:favorited_users)
  #.sort_by { |x| x.favorited_users.includes(:favorites).size }.reverse }


  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  def favorited_by?(user) #ログイン中のユーザーがその投稿に対していいねをしているか」を判断するメソッドを定義
    favorites.exists?(user_id: user.id)
  end

  def self.search_for(content, method)
    if method == 'perfect'
      Book.where(title: content)
    elsif method == 'forward'
      Book.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      Book.where('name LIKE ?', '%' + content)
    else
      Book.where('name LIKE ?', '%' + content + '%')
    end
  end



  #バリデーション
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
end
