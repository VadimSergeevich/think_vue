RSpec.shared_examples 'authenticate' do |model, wrong_model|
  let!(:user) { create(model) }
  let(:wrong_user) { create(wrong_model) }
  let!(:expired_token_user) { create(model, access_tokens_expired_at: Time.now.to_i - 10) }

  describe 'Fail auth' do
    it 'redirect when no token and cookie' do
      get :index
      expect(response.status).to eq(302)
    end

    context 'api' do
      before(:each) do
        subject.request.headers.add('HTTP_ACCEPT', 'application/json')
      end

      it 'redirect when wrong user' do
        subject.request.env['HTTP_AUTHORIZATION'] = "Bearer #{wrong_user.reload.access_token}"
        get :index
        expect(response.status).to eq(401)
      end

      it 'when access token expired' do
        subject.request.env['HTTP_AUTHORIZATION'] = "Bearer #{expired_token_user.reload.access_token}"
        get :index

        expect(JSON(response.body)).to eq('error' => 'Access token expired')
        expect(response.status).to eq(401)
      end
    end
  end

  describe 'Token auth valid' do
    it 'success when token valid' do
      subject.request.env['HTTP_AUTHORIZATION'] = "Bearer #{user.reload.access_token}"
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'Cookie auth valid' do
    it 'success when token valid' do
      request.env['devise.mapping'] = Devise.mappings[model]
      sign_in user
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
