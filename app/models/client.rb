class Client < ApplicationRecord
  devise :database_authenticatable, :rememberable, :validatable
  include Tokenable
end
