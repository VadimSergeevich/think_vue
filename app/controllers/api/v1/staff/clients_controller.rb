class Api::V1::Staff::ClientsController < Api::V1::Staff::BaseController

  def validate
    if Client.find_by(client_params)
      render json: { errors: { client_params.keys.first => 'Not uniq' } }
    else
      render json: {}
    end
  end

  def index
    render json: ClientSerializer.new(index_query.includes(:organizations).order(created_at: :desc)).serialized_json
  end

  def create
    client = Client.new(client_params)

    if client.save
      render json: ClientSerializer.new(client).serialized_json
    else
      render json: { errors: client.errors.messages }
    end
  end

  def show
    render json: ClientSerializer.new(Client.find(params[:id])).serialized_json
  end

  def update
    client = Client.find(params[:id])
    client_params.delete('password') if client_params[:password].blank?

    if client.update(client_params)
      render json: ClientSerializer.new(client).serialized_json
    else
      errors = client.errors.messages.reduce({}) { |h, (k, v)| h[k] = v.join(', '); h }
      render json: { errors: errors}, status: :unprocessable_entity
    end
  end


  private

  def index_query
    return Client.all unless params[:fullname]

    Client.where("fullname ILIKE :fullname", fullname: "%#{params[:fullname]}%")
  end

  def client_params
    params.require(:client).permit(:fullname, :email, :phone, :password, organization_ids: [])
  end
end
