# テーブル設計

## users テーブル

| Colum              | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |

### Association

- has_many :tweets
- has_many :comments

## tweets テーブル

| Colum | Type   | Options     |
| ----- | ------ | ----------- |
| text  | text   | null: false |
| img   | string |             |

### Association

- has_many :comments
- belongs_to :user

## comments テーブル

| Colum   | Type | Options     |
| ------- | ---- | ----------- |
| message | text | null: false |

### Association

- belongs_to :user
- belongs_to :tweet