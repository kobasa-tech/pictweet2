class UsersController < ApplicationController
  def show
    user = User.find(params[:id]) # あるユーザーの詳細ページに遷移する際のパラメーターからidを取得
    @nickname = user.nickname #取得したidのユーザーのニックネームカラムを取得してインスタンス変数に代入
    @tweets = user.tweets #取得したidのユーザーが投稿したツイート全てを取得してインスタンス変数に代入
    # 取得したパラメーター Parameters: {"id"=>"2"}
  end
end