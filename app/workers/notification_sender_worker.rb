# frozen_string_literal: true

class NotificationSenderWorker
  include Sidekiq::Worker

  def perform(message_payload)
    response = TelegramApiService.new.send_message(message_payload)
    return unless response.status != 200

    Rails.logger.error response.body
  end
end
