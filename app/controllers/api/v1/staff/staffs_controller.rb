class Api::V1::Staff::StaffsController < Api::V1::Staff::BaseController

  def index
    render json: StaffSerializer.new(Staff.all.order(created_at: :desc)).serialized_json
  end

  def create
    staff = Staff.new(staff_params)

    if staff.save
      render json: StaffSerializer.new(staff).serialized_json
    else
      errors = staff.errors.messages.reduce({}) { |h, (k, v)| h[k] = v.join(', '); h }
      render json: { errors: errors}, status: :unprocessable_entity
    end
  end

  def show
    render json: StaffSerializer.new(Staff.find(params[:id])).serialized_json
  end

  def update
    staff = Staff.find(params[:id])
    staff_params.delete('password') if staff_params[:password].blank?

    if staff.update(staff_params)
      render json: StaffSerializer.new(staff).serialized_json
    else
      errors = staff.errors.messages.reduce({}) { |h, (k, v)| h[k] = v.join(', '); h }
      render json: { errors: errors}, status: :unprocessable_entity
    end
  end


  private

  def staff_params
    @staff_params ||= params.require(:staff).permit(:email, :password)
  end
end
