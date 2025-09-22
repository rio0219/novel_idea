class CreateCharacters < ActiveRecord::Migration[7.2]
  def change
    create_table :characters do |t|
      t.references :work, null: false, foreign_key: true
      t.string :name
      t.integer :age
      t.string :gender
      t.string :hair_color
      t.string :eye_color
      t.string :physique
      t.text :others
      t.text :personality
      t.text :background

      t.timestamps
    end
  end
end
