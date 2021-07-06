Rails.application.routes.draw do
  root to: 'tweets#index'
  # ルートパス(localhost:3000へのパス)を記述
  resources :tweets
  # resourcesメソッドでルーティングを記述
  # resources :コントローラー名, onlyオプション: :必要なアクション名(シンボル)
end
# ルーティングが作成できたらrails g controller コントローラー名(複数形) でコントローラーを作成