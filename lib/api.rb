require 'httparty'

class API
  include HTTParty
  base_uri Settings.server.base_uri

  def initialize
  end

  def self.log(data)
    post(Settings.server.logs_path, post_options(data))
  end

  def self.post_options(data)
    {
      body: data.to_json,
      headers: { 'Content-Type' => 'application/json' }
    }
  end
end
