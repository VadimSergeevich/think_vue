class OrganizationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :inn, :ogrn, :id

  attribute :kind do |org|
    org.kind&.gsub('_', ' ')
  end
end
