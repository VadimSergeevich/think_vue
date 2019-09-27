class Client < ApplicationRecord
  devise :database_authenticatable, :rememberable, :validatable
  include Tokenable
  validates :fullname, :phone, presence: true
  has_many :clients_organizations
  has_many :organizations, through: :clients_organizations

  protected

  def password_required?
    false
  end
end
