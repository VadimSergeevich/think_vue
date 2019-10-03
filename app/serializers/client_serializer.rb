class ClientSerializer
  include FastJsonapi::ObjectSerializer
  attributes :fullname, :email, :phone, :id

  attribute :organization_ids do |org|
    org.organizations.map(&:id)
  end

  attribute :organizations do |org|
    org.organizations.map { |c| {value: c.id, label: c.name} }
  end
end
