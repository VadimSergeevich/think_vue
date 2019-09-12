class Client < ApplicationRecord
  devise :database_authenticatable, :rememberable, :validatable
  include Tokenable
  validates :fullname, :phone, presence: true

  protected

  def password_required?
    false
  end
end
