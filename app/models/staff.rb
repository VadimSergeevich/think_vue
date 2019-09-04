class Staff < ApplicationRecord
  devise :database_authenticatable, :rememberable, :validatable
end
