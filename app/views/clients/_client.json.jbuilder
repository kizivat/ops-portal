json.extract! client, :id, :name, :url, :api_token_public_key, :created_at, :updated_at
json.url client_url(client, format: :json)
