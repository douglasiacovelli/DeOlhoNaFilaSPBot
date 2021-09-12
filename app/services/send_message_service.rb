# frozen_string_literal: true

class SendMessageService
  def self.call(
    service_chat_id:,
    message_payload: {},
    text: nil,
    edit_message: false,
    save_message_id: false
  )
    new(service_chat_id, message_payload, text, edit_message, save_message_id).call
  end

  def initialize(service_chat_id, message_payload, text, edit_message, save_message_id)
    @service_chat_id = service_chat_id
    @message_payload = message_payload
    @text = text
    @edit_message = edit_message
    @save_message_id = save_message_id
  end

  def call
    @message_payload['chat_id'] = @service_chat_id.to_s
    @message_payload['text'] = @text
    @message_payload['parse_mode'] = 'MarkdownV2'

    chat_id = Chat.find_or_create_by(telegram_chat_id: @service_chat_id).id
    NotificationSenderWorker.perform_async(
      @message_payload,
      @save_message_id,
      @edit_message,
      chat_id
    )
  end
end
