RSpec.describe Staff::HomeController, type: :controller do
  it_behaves_like 'authenticate', :staff, :client
  subject { controller }
end
