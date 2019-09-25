class ClientSerializer
  include FastJsonapi::ObjectSerializer
  attributes :fullname, :email, :phone
end
