class CreateAiConsultations < ActiveRecord::Migration[7.2]
  def change
    create_table :ai_consultations do |t|
      t.text :content
      t.text :response
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
