class AddApiTokenToStaff < ActiveRecord::Migration[6.0]
  def change
    add_column :staffs, :api_token, :string, default: -> { 'gen_random_uuid()' }
    add_index :staffs, :api_token, unique: true
  end
end
