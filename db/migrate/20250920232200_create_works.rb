class CreateWorks < ActiveRecord::Migration[7.2]
  def change
    create_table :works do |t|
      t.references :user, null: false, foreign_key: true
      t.references :genre, null: false, foreign_key: true
      t.string :title
      t.string :theme
      t.text :synopsis

      t.timestamps
    end
  end
end
