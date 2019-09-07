class ApiTokenStrategy < Warden::Strategies::Base
  def valid?
    access_token.present?
  end

  def authenticate!
    user = Kernel.const_get(scope.to_s.capitalize).find_by(access_token: access_token)

    if user && !access_token_expired?(user)
      success!(user)
    elsif user && access_token_expired?(user)
      fail!('Access token expired')
    else
      fail!('Invalid access token')
    end
  end

  private

  def access_token_expired?(user)
    user.access_tokens_expired_at < Time.now.to_i
  end

  def access_token
    env['HTTP_AUTHORIZATION'].to_s.remove('Bearer ')
  end
end
