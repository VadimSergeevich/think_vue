class AddRefreshTokenToClient < ActiveRecord::Migration[6.0]
  def change
    refresh_tokens_default =
      "jsonb_build_object(gen_random_uuid(), (extract(epoch from now()) + #{Rails.application.config.refresh_tokens_ttl })::int)"
    access_tokens_expired_at_default =  "(extract(epoch from now()) + #{Rails.application.config.access_tokens_ttl })::int"

    add_column :clients, :refresh_tokens, :jsonb, default: -> { refresh_tokens_default }
    add_column :clients, :access_tokens_expired_at, :integer, default: -> { access_tokens_expired_at_default }
    rename_column :clients, :api_token, :access_token
  end
end
