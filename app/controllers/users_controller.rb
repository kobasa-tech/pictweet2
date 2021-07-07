class UsersController < ApplicationController
  def show
    @nickname = current_user.nickname #ログインしているユーザーのニックネームカラムを取得してインスタンス変数に代入
    @tweets = current_user.tweets #ログインしているユーザーが投稿したツイート全てを取得してインスタンス変数に代入
  end
end