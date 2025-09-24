class CreatePlots < ActiveRecord::Migration[7.2]
  def change
    create_table :plots do |t|
      t.references :work, null: false, foreign_key: true
      t.string :chapter_title
      t.text :purpose
      t.text :event

      t.timestamps
    end
  end
end
