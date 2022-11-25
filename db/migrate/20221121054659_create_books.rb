class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title   #本のタイトル
      t.text :opinion   #感想文
      t.integer :user_id   #投稿したuserのid(Usesテーブルのidカラム)
      t.timestamps
    end
  end
end
