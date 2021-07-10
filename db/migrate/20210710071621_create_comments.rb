class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :tweet_id
      # user_idとtweet_idを数字の型で設定
      # Commentのアソシエーションが belongs_to :user, belongs_to :tweetとなるため必要。
      t.text :text
      # コメント内容を長文で設定
      t.timestamps
    end
  end
end
