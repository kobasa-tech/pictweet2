class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all
    # インスタンス変数@tweets(複数のレコードが入るので複数形)にTweetモデルのテーブルレコード全てを代入。
    # 一覧表示画面に投稿された全てのツイートを並べたいのでindexアクションに記述している。
    # 1つのレコードにはハッシュの記述でカラム名: "値" がキーバリューで保存されている。<id: 1, name: "takashi", text: "Nice to meet you!",~>
  end
end
