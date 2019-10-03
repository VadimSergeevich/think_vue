class Api::V1::Staff::EquipmentsController < Api::V1::Staff::BaseController

  def index
    render json: EquipmentSerializer.new(Equipment.all.order(created_at: :desc)).serialized_json
  end

  def create
    equipment = Equipment.new(equipment_params)

    if equipment.save
      render json: EquipmentSerializer.new(equipment).serialized_json
    else
      render json: { errors: equipment.errors.messages }, status: :unprocessable_entity
    end
  end

  def show
    render json: EquipmentSerializer.new(Equipment.find(params[:id])).serialized_json
  end

  def update
    equipment = Equipment.find(params[:id])

    if equipment.update(equipment_params)
      render json: EquipmentSerializer.new(equipment).serialized_json
    else
      errors = equipment.errors.messages.reduce({}) { |h, (k, v)| h[k] = v.join(', '); h }
      render json: { errors: errors}, status: :unprocessable_entity
    end
  end


  private

  def equipment_params
    params.require(:equipment).permit(:title, :kind, :serial, :organization_id)
  end
end
