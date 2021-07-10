class Tweet < ApplicationRecord
  validates :text, presence: true
  # textカラムが空では投稿できない、という制約。validates :カラム名(シンボル), presence: true(空では登録できない)
  belongs_to :user
  # アソシエーションの設定。ツイート対ユーザーは他対1の関係。
  # アソシエーションでbelongs_toを指定した場合、相手のモデルのid(user_id)が
  # 「空ではないか」というバリデーション validates :user_id, presence: true がデフォルトでかかるようになっている。
  has_many :comments

  def self.search(search)
    # クラスメソッドでsearchを定義。クラスメソッドにしないとtweetsコントローラーで使用できない！引数にsearchを使用(検索ボックスの値)
    if search != ""
      Tweet.where('text LIKE(?)', "%#{search}%")
      # もし検索ボックスの値が空白でなければツイートテーブルから検索ボックスの値を含む、textカラムのレコードを取得する
    else
      Tweet.all
      # 検索ボックスの値が空白ならツイートテーブルから全てのレコードを取得する。
    end
  end
end
