class CommentsController < ApplicationController
  def create
    comment = Comment.create(comment_params)
    # comment_paramsメソッドの内容をCommentテーブルに保存し、変数commentに代入。
    redirect_to "/tweets/#{comment.tweet.id}"
    # リダイレクト先はコメントしたツイートのshowアクション。保存したコメントに結びつくツイートのidをパスに入れている。
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id,tweet_id: params[:tweet_id])
    # パラメーターとしてテキストに加え、現在のユーザーidとコメントを書き込んでいるツイートのid情報を取得する。
  end
end