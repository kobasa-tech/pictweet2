class CommentsController < ApplicationController
  def create
    comment = Comment.create(comment_params)
    # comment_paramsメソッドの内容をCommentテーブルに保存し、変数commentに代入。
    redirect_to "/tweets/#{comment.tweet.id}"
    # リダイレクト先はコメントしたツイートのshowアクション。保存したコメントに結びつくツイートのidをルートパスに入れている。
  end

  private
  def comment_params
    # Parameters {"authenticity_token"=>"KW6xJ/略==", "comment"=>{"text"=>"params"}, "commit"=>"SEND", "controller"=>"comments",
    #  "action"=>"create", "tweet_id"=>"7"} permitted: false>
    params.require(:comment).permit(:text).merge(user_id: current_user.id,tweet_id: params[:tweet_id])
    # パラメーターとしてテキストに加え、現在のユーザーidとコメントを書き込んでいるツイートのid情報を取得する。
    # tweet_idキーのバリューであるparams[:tweet_id]はネストしたルーティングで取得できるtweet_idである。
    # Parameters {"text"=>"params", "user_id"=>4, "tweet_id"=>"7"} permitted: true>
  end
end