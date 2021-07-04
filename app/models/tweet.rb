class Tweet < ApplicationRecord
  validates :text, presence: true
  # textカラムが空では投稿できない、という制約。validates :カラム名(シンボル), presence: true(空では登録できない)
end
