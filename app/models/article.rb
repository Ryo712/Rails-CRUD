class Article < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 3} #bodyの文字数3字以上。
end
