class Api::V1::Staff::ClientsController < Api::V1::Staff::BaseController

  def validate
    if Client.find_by(client_params)
      render json: { errors: { client_params.keys.first => 'Not uniq' } }
    else
      render json: {}
    end
  end

  def index
    render json: ClientSerializer.new(Client.all.order(created_at: :desc)).serialized_json
  end

  def create
    client = Client.new(client_params)

    if client.save
      render json: ClientSerializer.new(client).serialized_json
    else
      render json: { errors: client.errors.messages }
    end
  end

  private

  def client_params
    params.require(:client).permit(:fullname, :email, :phone)
  end
end
