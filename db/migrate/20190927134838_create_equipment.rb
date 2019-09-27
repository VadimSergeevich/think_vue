class CreateEquipment < ActiveRecord::Migration[6.0]
  def change
    create_table :equipment do |t|
      t.string :title
      t.integer :kind
      t.string :serial
      t.references :organization, foreign_key: true

      t.timestamps
    end
  end
end
