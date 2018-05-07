class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.string :body, null: false
      t.integer :author_id, null: false, index: true, foreign_key: true
      t.timestamps
    end
  end
end
