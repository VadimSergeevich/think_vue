# frozen_string_literal: true

class DeviseCreateStaffs < ActiveRecord::Migration[6.0]
  def change
    create_table :staffs do |t|
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.datetime :remember_created_at

      t.timestamps null: false
    end

    add_index :staffs, :email,                unique: true
    add_index :staffs, :reset_password_token, unique: true
  end
end
