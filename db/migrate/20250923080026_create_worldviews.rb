class CreateWorldviews < ActiveRecord::Migration[7.0]
  def change
    create_table :worldviews do |t|
      t.references :work, null: false, foreign_key: true
      t.string :country
      t.text :culture
      t.text :technology
      t.text :faction

      t.timestamps
    end
  end
end
