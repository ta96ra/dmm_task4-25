class AddColumnToUsers < ActiveRecord::Migration[6.1]
  # nameカラムに一意性を持たせるための
  def change
    add_index :users, :name, unique: true
  end
end
