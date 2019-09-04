RSpec.describe Client::HomeController, type: :controller do
  it_behaves_like 'authenticate', :client, :staff
  subject { controller }
end
