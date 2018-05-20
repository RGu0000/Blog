class CreateRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :ratings do |t|
      t.decimal :rate, precision: 3, scale: 1
      t.integer :author_id, null: false, index: true, foreign_key: true
      t.integer :article_id, null: false, index: true, foreign_key: true
      t.timestamps
    end
  end
end
