RSpec.shared_examples 'authenticate' do |model, wrong_model|
  let!(:user) { create(model) }
  let!(:wrong_user) { create(wrong_model) }

  describe 'Fail auth' do
    it 'redirect when no token and cookie' do
      get :index
      expect(response.status).to eq(302)
    end

    it 'redirect when wrong user' do
      subject.request.env['HTTP_AUTHORIZATION'] = "Bearer #{wrong_user.reload.api_token}"
      get :index
      expect(response.status).to eq(302)
    end
  end

  describe 'Token auth valid' do
    it 'success when token valid' do
      subject.request.env['HTTP_AUTHORIZATION'] = "Bearer #{user.reload.api_token}"
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'Cookie auth valid' do
    it 'success when token valid' do
      request.env["devise.mapping"] = Devise.mappings[model]
      sign_in user
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
