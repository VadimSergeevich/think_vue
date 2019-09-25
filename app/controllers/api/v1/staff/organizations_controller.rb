class Api::V1::Staff::OrganizationsController < Api::V1::Staff::BaseController

  def index
    render json: OrganizationSerializer.new(Organization.all.order(created_at: :desc)).serialized_json
  end

  def create
    organization = Organization.new(organization_params)

    if organization.save
      render json: OrganizationSerializer.new(organization).serialized_json
    else
      render json: { errors: organization.errors.messages }, status: :unprocessable_entity
    end
  end

  private

  def organization_params
    params.require(:organization).permit(:name, :kind, :inn, :ogrn)
  end
end
