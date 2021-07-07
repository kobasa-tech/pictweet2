class Tweet < ApplicationRecord
  validates :text, presence: true
  # textカラムが空では投稿できない、という制約。validates :カラム名(シンボル), presence: true(空では登録できない)
  belongs_to :user
  # アソシエーションの設定。ツイート対ユーザーは他対1の関係。
  # アソシエーションでbelongs_toを指定した場合、相手のモデルのid(user_id)が
  # 「空ではないか」というバリデーション validates :user_id, presence: true がデフォルトでかかるようになっている。
end
