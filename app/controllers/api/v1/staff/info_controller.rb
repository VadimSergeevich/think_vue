class Api::V1::Staff::InfoController < Api::V1::Staff::BaseController
  def me
    render json: { data: { email: current_staff.email } }.to_json
  end
end
