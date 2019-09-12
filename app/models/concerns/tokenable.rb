module Tokenable
  extend ActiveSupport::Concern

  def new_tokens
    epoch_time_now = Time.now.to_i
    access_token = SecureRandom.uuid
    new_refresh_token = SecureRandom.uuid
    access_tokens_expired_at = epoch_time_now + Rails.application.config.access_tokens_ttl
    new_refresh_token_with_expired = { new_refresh_token => epoch_time_now + Rails.application.config.refresh_tokens_ttl }

    update(
      access_token: access_token,
      access_tokens_expired_at: access_tokens_expired_at,
      refresh_tokens: refresh_tokens.merge(new_refresh_token_with_expired)
    )

    { access_token: access_token, refresh_token: new_refresh_token, expires_at: access_tokens_expired_at }
  end
end
