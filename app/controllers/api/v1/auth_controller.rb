class Api::V1::AuthController < ApplicationController
  def create
    klass = params[:scope].constantize
    resource = klass.find_for_database_authentication(email: params[:email])

    if resource.present?
      if resource.valid_password?(params[:password])
        render json: { data: resource.new_tokens }
      else
        render json: { errors: ['Incorrect Email/Passoword'] }, status: :unauthorized
      end
    else
      render json: { errors: ['User not found'] }, status: :not_found
    end
  end

  def refresh_token
    klass = params[:scope].constantize
    resource = klass.where("refresh_tokens ->> ? > '?'", params[:refresh_token], Time.now.to_i).take
    if resource.present?
      render json: { data: { access_token: resource.access_token, expires_at: resource.access_tokens_expired_at } }
    else
      render json: { errors: ['Invalid refresh token'] }, status: :unauthorized
    end
  end
end
