class Relationship < ApplicationRecord
  #followerテーブルとfollowedテーブルを探しに行ってしまうので、class_name: "User"でuserテーブルからデータをとってきてもらう
  belongs_to :follower, class_name: "User" #１人のユーザーはたくさんのユーザーをフォローできる(1:N) フォローしたユーザー
  belongs_to :followed, class_name: "User" #１人のユーザーはたくさんのユーザーにフォローされる(1:N) フォローされたユーザー
end
