class StaffSerializer
  include FastJsonapi::ObjectSerializer
  attributes :email, :id
end
