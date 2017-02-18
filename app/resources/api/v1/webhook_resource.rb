class Api::V1::WebhookResource < JSONAPI::Resource
  attributes :identifier, :url, :headers, :body, :auth, :retry_limit, :timeout,
    :status

  # associations
  has_many :deliveries

  # prevent setting of status
  def self.creatable_fields(context)
    super - [:status]
  end

  # prevent setting of status
  def self.updatable_fields(context)
    super - [:status]
  end

  def auth
    {
      username: _model.basic_auth_username,
      password: _model.basic_auth_password
    }.compact
  end

  def auth=(value)
    _model.basic_auth_username = value[:username]
    _model.basic_auth_password = value[:password]
  end
end
