class Client::HomeController < ActionController::Base
  before_action :authenticate_client!
  def index; end
end
