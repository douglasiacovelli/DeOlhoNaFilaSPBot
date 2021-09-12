# frozen_string_literal: true

class NotificationSenderWorker
  include Sidekiq::Worker

  def perform(message_payload, save_message_id, edit_message, chat_id)
    chat = Chat.find(chat_id)
    response = if edit_message && chat.message_id.present?
                 message_payload['message_id'] = chat.message_id
                 TelegramApiService.new.edit_message(message_payload)
               else
                 TelegramApiService.new.send_message(message_payload)
               end

    if response.status == 200 && save_message_id
      chat.message_id = response.body['result']['message_id']
      chat.save
      return
    end
    Rails.logger.error response.body
  end
end
