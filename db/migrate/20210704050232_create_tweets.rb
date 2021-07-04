class CreateTweets < ActiveRecord::Migration[6.0]
  def change
    create_table :tweets do |t|
      # t.カラムの型 :カラム名 で記述する。
      t.string :name
      #.短文 :ツイートしたユーザー名
      t.string :text
      # .短文 :ツイート内容
      t.text :image
      # .長文 画像のurl
      t.timestamps
    end
  end
end
# 記述したらrails db:migrateを実施