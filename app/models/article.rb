class Article < ApplicationRecord #Articleモデルクラスの定義
  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 3 } # bodyの文字数3字以上。
  has_one_attached :image
  
  # 仮想属性を追加（画像削除フラグ用）
  attr_accessor :remove_image # remove_imageはDBに保存されない（articlesテーブルにremove_imageカラムがないため）
  
  # 画像のファイル形式をバリデーション
  validate :image_content_type
  
  private
  
  def image_content_type
    if image.attached? && !image.content_type.in?(%w[image/jpeg image/png image/gif]) #.in?(配列)含まれている場合true
      errors.add(:image, '：ファイル形式が、JPEG, PNG, GIF以外になってます。ファイル形式をご確認ください。')
    end
  end
end