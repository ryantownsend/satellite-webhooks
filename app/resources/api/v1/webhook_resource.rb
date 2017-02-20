class Api::V1::WebhookResource < JSONAPI::Resource
  attributes :identifier, :url, :headers, :body, :auth, :retry_limit, :timeout,
    :status, :proxy, :signatures, :event_source

  # associations
  has_many :deliveries

  # prevent setting of status
  def self.creatable_fields(context)
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

  def proxy
    if _model.proxy_enabled? && _model.proxy_url
      _model.proxy_url
    else
      _model.proxy_enabled?
    end
  end

  def proxy=(value)
    if value.kind_of?(String)
      _model.proxy_url = value
      _model.proxy_enabled = true
    else
      _model.proxy_url = nil
      _model.proxy_enabled = !!value
    end
  end
end
