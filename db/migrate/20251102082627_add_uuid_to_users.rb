class AddUuidToUsers < ActiveRecord::Migration[7.0]
  def change
    # UUIDカラムを追加
    add_column :users, :uuid, :uuid, default: "gen_random_uuid()", null: false

    # 既存データにもユニーク制約を適用
    add_index :users, :uuid, unique: true
  end
end
