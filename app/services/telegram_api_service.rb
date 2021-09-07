require 'faraday'
require 'faraday_middleware'

class TelegramApiService

  def initialize
    @faraday = Faraday.new(
      url: Rails.configuration.telegram_api_url,
      headers: {'Content-Type' => 'application/json'}
    ) do |f|
      f.request :json
      f.response :json
    end
  end

  def sendMessage(payload)
    @faraday.post('sendMessage') do |req|
      req.body = payload.to_json
    end
  end
end
