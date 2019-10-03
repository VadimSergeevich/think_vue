class OrganizationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :inn, :ogrn, :id

  attribute :kind do |org|
    org.kind&.gsub('_', ' ')
  end

  attribute :client_ids do |org|
    org.clients.map(&:id)
  end

  attribute :clients do |org|
    org.clients.map { |c| {value: c.id, label: c.fullname} }
  end
end

