# frozen_string_literal: true

class SendMessageService
  def self.call(chat_id:, message_payload: {}, text: nil)
    new(chat_id, message_payload, text).call
  end

  def initialize(chat_id, message_payload, text)
    @chat_id = chat_id
    @message_payload = message_payload
    @text = text
  end

  def call
    @message_payload['chat_id'] = @chat_id.to_s
    @message_payload['text'] = @text
    @message_payload['parse_mode'] = 'MarkdownV2'

    response = TelegramApiService.new.sendMessage(@message_payload)
    response.body
  end
end
