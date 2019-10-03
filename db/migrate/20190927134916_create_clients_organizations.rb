class CreateClientsOrganizations < ActiveRecord::Migration[6.0]
  def change
    create_table :clients_organizations do |t|
      t.references :client, null: false, foreign_key: true
      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end
  end
end
