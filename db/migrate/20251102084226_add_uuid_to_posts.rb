class AddUuidToPosts < ActiveRecord::Migration[7.0]
  def change
    # UUIDカラムを追加
    add_column :posts, :uuid, :uuid, default: "gen_random_uuid()", null: false

    # 一意制約を追加
    add_index :posts, :uuid, unique: true
  end
end
