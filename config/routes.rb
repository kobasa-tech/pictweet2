Rails.application.routes.draw do
  devise_for :users
  root to: 'tweets#index'
  # ルートパス(localhost:3000へのパス)を記述
  resources :tweets do
    resources :comments, only: :create
    # ルーティングをネストすることでtweetのidをcommentsコントローラーに送れる
    # ralis routesのURI /tweets/:tweet_id/comments(.:format)
  end
  # resourcesメソッドでルーティングを記述
  # resources :コントローラー名, onlyオプション: :必要なアクション名(シンボル)
  resources :users, only: :show
  # ユーザーマイページを実装するためにのusersコントローラーのshowアクションのルーティングを設定
end
# ルーティングが作成できたらrails g controller コントローラー名(複数形) でコントローラーを作成