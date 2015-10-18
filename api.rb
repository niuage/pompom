require 'httparty'

class API
  include HTTParty
  base_uri Settings.server.base_uri

  def initialize
  end

  def self.logs(data)
    post(Settings.server.logs_path, post_options(data))
  end

  def self.post_options(data)
    puts data.to_json
    {
      body: data.to_json,
      headers: { 'Content-Type' => 'application/json' }
    }
  end
end
