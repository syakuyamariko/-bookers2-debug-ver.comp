class BookComment < ApplicationRecord
  belongs_to :user
  belongs_to :book
  #UserモデルもBookモデルも関連付けられるのは1つのため、belongs_toを記述

   #バリデーション
  validates :comment,presence:true
end
