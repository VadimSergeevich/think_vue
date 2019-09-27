class EquipmentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :kind, :serial, :id, :organization_id

  attribute :organization do |client|
    client.organization ? {value: client.organization.id, label: client.organization.name} : {}
  end
end

