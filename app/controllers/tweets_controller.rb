class TweetsController < ApplicationController
  before_action :set_tweet, only: [:edit, :show]
  # before_action :メソッド名(シンボル), only: :アクション名(シンボル)
  # と記述することで指定したアクションの実行前に指定したメソッドの処理が実行される
  before_action :move_to_index, except: [:index, :show]
  # exceptオプションでメソッドを実行しないアクションを指定している。
  # indexアクションを指定しないと永遠にindexアクションへのリダイレクトを繰り返してしまう。

  def index
    @tweets = Tweet.includes(:user).order("created_at DESC")
    # モデル名.includes(:紐づくモデル名(単数形のシンボル))
    # order("基準とするカラム名 並び順") orderメソッドを追記して、取得したレコードを新しく投稿された順(created_atカラムが降順)に並べている
    # インスタンス変数@tweets(複数のレコードが入るので複数形)にTweetモデルのテーブルレコード全てを代入。
    # 一覧表示画面に投稿された全てのツイートを並べたいのでindexアクションに記述している。
    # 1つのレコードにはハッシュの記述でカラム名: "値" がキーバリューで保存されている。<id: 1, name: "takashi", text: "Nice to meet you!",~>

    # @tweets = Tweet.all ではtweetsテーブルを取得した後、usersテーブルのレコードごとに投稿したツイート情報を確認する処理が発生してしまう。
    # これをN+1問題という。これを回避するためにincludesメソッドを使用して、
    # tweetsテーブルの全データを取得。tweetsテーブルに紐づく(user_id)usersテーブルのデータを取得。の2回で処理が済むようにしている。
    # includesメソッドでテーブルの全データを取得するため .allは不要。
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
    @comment = Comment.new
    # コメント投稿を投稿すると、Commentコントローラーのcreateアクションが実行されるリクエストを記述
    # tweetのビューなのでtweetコントローラーに記述する必要がある。
    @comments = @tweet.comments.includes(:user)
    # 選択しているツイートが持っているコメント全てを取得しインスタンス変数@commentsに代入。
    # Tweet has_many :commentsのアソシエーションのためこのような記述で取得できる。
    # 誰のコメントかを明らかにするためusersテーブルのレコードを取得するのでincludesメソッドでN+1問題を回避する記述。
  end

  # 以下ストロングパラメーター(意図しないデータベースの読み書きを防ぐための記述)private・require・permitで構成
  private
  # private以下はクラス外(tweetsコントローラー以外)から呼び出せなくなる。
  def tweet_params
    params.require(:tweet).permit(:image, :text).merge(user_id: current_user.id) # nameのパラメーターが不要に
    # フォームから送られてきたツイート時のパラメータを制限してparamsに取得させている。
    # さらにどのユーザーのツイートか判断できるようにmergeメソッドでハッシュ状のparamsに{user_id(キー): ログインしているユーザーのid(バリュー)}を結合している
    # requireメソッド require(:モデル名(シンボル)) permitメソッド permit(:キー(カラム名))
    # 送られてきたデータ Parameters: {"authenticity_token"=>"i7BS6y/~略~/GuPTlKlkd7fTeawTDsa0GIfKjCC+GBBw==", "tweet"=>{"name"=>"勉強男", "image"=>"", "text"=>"パラメータ確認", "user_id"=>"1"}, "commit"=>"SEND"}
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
    # show・editアクションのbefore_actionで使用。
    # 選択されたツイートのid(送られてきたデータ)と一致するidのレコードをテーブルから探し出し、インスタンス変数に代入している。
    # 詳細表示や編集画面では選択されたツイートの情報をビューに表示するのでインスタンス変数が必要。
    # 送られてきたデータ Parameters: {"authenticity_token"=>"PbJCidedTv7ZSdFwP35MlScmr1ha0KK3lE5UaPZ1dImPxQ+80eKi+qiUGv6/BdYTtRzeiNIOk4v93LIxk52Udg==", "id"=>"5"}
  end

  def move_to_index
        # show・editアクションを除くbefore_actionで使用。
    unless user_signed_in?
      # user_signed_in?がfalse(サインインしていない)の時実行
      redirect_to action: :index
      # indexアクションに転送する。
    end
  end
end