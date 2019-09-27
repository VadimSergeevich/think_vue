class Organization < ApplicationRecord
  enum kind: { individual: 0, legal: 1 }
  has_many :clients_organizations
  has_many :clients, through: :clients_organizations
  has_many :equipment
end
