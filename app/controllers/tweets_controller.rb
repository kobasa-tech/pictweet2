class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all
    # インスタンス変数@tweets(複数のレコードが入るので複数形)にTweetモデルのテーブルレコード全てを代入。
    # 一覧表示画面に投稿された全てのツイートを並べたいのでindexアクションに記述している。
    # 1つのレコードにはハッシュの記述でカラム名: "値" がキーバリューで保存されている。<id: 1, name: "takashi", text: "Nice to meet you!",~>
  end

  def new
    @tweet = Tweet.new
    # Tweetテーブルに保存するために、空のインスタンスを作成し@tweetに代入。form_withのmodelオプションで使用する。
  end

  def create
    Tweet.create(tweet_params)
    # paramsで取得したデータをtweetsテーブルに保存している
  end

  def destroy
    tweet = Tweet.find(params[:id])
    # Tweetテーブルから送られてきたパラメータ(id番号)と一致するid番号のレコードを探して変数に代入している。
    # この変数はビューに表示させたりしないのでインスタンス変数でなくて良い。method: :deletelのink_toのパスからデータをもらっている。
    # 送られてきたデータ Parameters: {"authenticity_token"=>"PbJCidedTv7ZSdFwP35MlScmr1ha0KK3lE5UaPZ1dImPxQ+80eKi+qiUGv6/BdYTtRzeiNIOk4v93LIxk52Udg==", "id"=>"5"}
    tweet.destroy
    # 一致したレコードを削除している。
  end

  def edit
    @tweet = Tweet.find(params[:id])
    # 編集機能の場合は最初からツイートの内容が表示されており、それを編集するという作業になるので投稿時のデータが必要になる。
    # 送られてきたデータのidの値と一致するidのレコードをTweetテーブルから探して、インスタンス変数に代入している。
    # ビューで使用するのでインスタンス変数にする必要がある。
    # 送られてきたデータ Parameters: {"authenticity_token"=>"PbJCidedTv7ZSdFwP35MlScmr1ha0KK3lE5UaPZ1dImPxQ+80eKi+qiUGv6/BdYTtRzeiNIOk4v93LIxk52Udg==", "id"=>"5"}
  end

  def update
    tweet = Tweet.find(params[:id])
    # ビューに表示させないので変数に代入。まずはモデルオプションから送られてきたidのデータを元にテーブルからidの一致したレコードを取得している。
    # editでも同じように取得しているが、そちらはあくまで編集画面に表示するため。こちらは更新元の特定をしている。
    tweet.update(tweet_params)
    # 取得したレコードをupdateメソッドを使用し送られてきたデータで上書きする。モデルのインスタンス.update(更新データ)
    # 更新できなかった場合の処理は後ほど。現在ではテキストが空で入力してもupdateビューに跳ぶがバリデーションがあるため更新されていない。
    # 送られてきたデータ Parameters: {"authenticity_token"=>"i7BS6y/~略~/GuPTlKlkd7fTeawTDsa0GIfKjCC+GBBw==", "tweet"=>{"name"=>"勉強男", "image"=>"", "text"=>"パラメータ確認"}, "commit"=>"SEND"}
  end

  def show
    @tweet = Tweet.find(params[:id])
    # 選択されたツイートのidと一致するレコードをテーブルから探し出し、インスタンス変数に代入している。
    # 詳細表示ではインスタンス選択されたツイートの画面を表示するのでインスタンス変数が必要
  end

  # 以下ストロングパラメーター(意図しないデータベースの読み書きを防ぐための記述)private・require・permitで構成
  private
  # private以下はクラス外(tweetsコントローラー以外)から呼び出せなくなる。
  def tweet_params
    params.require(:tweet).permit(:name, :image, :text)
    # フォームから送られてきたパラメータを制限してparamsに取得させている。
    # requireメソッド require(:モデル名(シンボル)) permitメソッド permit(:キー(カラム名))
    # 送られてきたデータ Parameters: {"authenticity_token"=>"i7BS6y/~略~/GuPTlKlkd7fTeawTDsa0GIfKjCC+GBBw==", "tweet"=>{"name"=>"勉強男", "image"=>"", "text"=>"パラメータ確認"}, "commit"=>"SEND"}
  end
end