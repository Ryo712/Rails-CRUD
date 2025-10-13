class Article < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 3} #bodyの文字数3字以上。
  has_one_attached :image
end

def image_content_type
  if image.attached? && !image.content_type.in?(%w[image/jpeg image/png image/gif])
    errors.add(:image, '：ファイル形式が、JPEG, PNG, GIF以外になってます。ファイル形式をご確認ください。')
  end

  
end
