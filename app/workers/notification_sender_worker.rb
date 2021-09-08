# frozen_string_literal: true

class NotificationSenderWorker
  include Sidekiq::Worker

  def perform(message_payload)
    TelegramApiService.new.sendMessage(message_payload)
  end
end
