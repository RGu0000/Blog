class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :body
      t.integer :author_id, null: false, index: true, foreign_key: true
      t.integer :article_id, null: false, index: true, foreign_key: true
      t.timestamps
    end
  end
end
