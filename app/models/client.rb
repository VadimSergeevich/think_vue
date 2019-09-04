class Client < ApplicationRecord
  devise :database_authenticatable, :rememberable, :validatable
end
