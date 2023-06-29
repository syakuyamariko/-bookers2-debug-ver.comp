class Book < ApplicationRecord
  belongs_to :user #修正した
  has_one_attached :image #追加した

  def get_image #追加した
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  #バリデーション
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
end
