class Api::V1::Staff::OrganizationsController < Api::V1::Staff::BaseController

  def index
    render json: OrganizationSerializer.new(index_query.includes(:clients).order(created_at: :desc)).serialized_json
  end

  def create
    organization = Organization.new(organization_params)

    if organization.save
      render json: OrganizationSerializer.new(organization).serialized_json
    else
      render json: { errors: organization.errors.messages }, status: :unprocessable_entity
    end
  end

  def show
    render json: OrganizationSerializer.new(Organization.find(params[:id])).serialized_json
  end

  def update
    organization = Organization.find(params[:id])

    if organization.update(organization_params)
      render json: OrganizationSerializer.new(organization).serialized_json
    else
      errors = organization.errors.messages.reduce({}) { |h, (k, v)| h[k] = v.join(', '); h }
      render json: { errors: errors}, status: :unprocessable_entity
    end
  end

  private

  def index_query
    return Organization.all unless params[:name]

    Organization.where("name ILIKE :name", name: "%#{params[:name]}%")
  end

  def organization_params
    params.require(:organization).permit(:name, :kind, :inn, :ogrn, client_ids: [])
  end
end
