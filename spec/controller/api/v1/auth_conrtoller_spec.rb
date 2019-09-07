RSpec.describe Api::V1::AuthController, type: :controller do
  describe 'POST #create' do
    let!(:resource) { create(%i[client staff].sample, password: 'password') }

    context 'valid credentials' do
      let(:valid_params) { { email: resource.email, password: 'password', scope: resource.class.to_s } }

      it 'login by email and password' do
        post :create, params: valid_params

        body = JSON(response.body)['data']

        expect(response).to have_http_status(:success)
        expect(body.keys).to eq(%w[access_token refresh_token expires_at])
      end
    end

    context 'invalid credentials' do
      let(:invalid_password) { { email: resource.email, password: 'wrong_password', scope: resource.class.to_s } }
      let(:invalid_email) { { email: 'test@test.com', password: 'password', scope: resource.class.to_s } }

      it 'wrong email' do
        post :create, params: invalid_email

        body = JSON(response.body)['errors']

        expect(response).to have_http_status(404)
        expect(body).to eq(['User not found'])
      end

      it 'wrong password' do
        post :create, params: invalid_password

        body = JSON(response.body)['errors']

        expect(response).to have_http_status(401)
        expect(body).to eq(['Incorrect Email/Passoword'])
      end
    end
  end

  describe 'POST #refresh_token' do
    let(:refresh_token) { SecureRandom.uuid }
    let(:resource_refresh_tokens) { { refresh_token => Time.now.to_i + 100 } }

    context 'valid credentials' do
      let!(:resource) { create(%i[client staff].sample, refresh_tokens: resource_refresh_tokens) }
      let(:valid_params) { { refresh_token: refresh_token, scope: resource.class.to_s } }

      it 'get new tokens by refresh_token' do
        post :refresh_token, params: valid_params

        body = JSON(response.body)['data']

        expect(response).to have_http_status(:success)
        expect(body.keys).to eq(%w[access_token expires_at])
      end
    end

    context 'invalid credentials' do
      let!(:resource) { create(%i[client staff].sample, refresh_tokens: resource_refresh_tokens) }
      let(:invalid_token_params) { { refresh_token: SecureRandom.uuid, scope: resource.class.to_s } }
      let(:expired_refresh_token) { SecureRandom.uuid }
      let(:expired_token_resource) {  create(%i[client staff].sample, refresh_tokens: { expired_refresh_token => Time.now.to_i - 100 }) }
      let(:expired_token_params) { { refresh_token: expired_refresh_token, scope: resource.class.to_s } }

      it 'wrong token' do
        post :refresh_token, params: invalid_token_params

        body = JSON(response.body)['errors']

        expect(response).to have_http_status(401)
        expect(body).to eq(['Invalid refresh token'])
      end

      it 'expired token' do
        post :refresh_token, params: expired_token_params

        body = JSON(response.body)['errors']

        expect(response).to have_http_status(401)
        expect(body).to eq(['Invalid refresh token'])
      end
    end
  end
end
