class CreateBookmarks < ActiveRecord::Migration[5.1]
  def change
    create_table :bookmarks do |t|
      t.integer :user_id, null: false, index: true, foreign_key: true
      t.integer :article_id, null: false, index: true, foreign_key: true
      t.timestamps
    end
  end
end
