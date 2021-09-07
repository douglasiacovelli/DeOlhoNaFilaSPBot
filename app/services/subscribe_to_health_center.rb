# frozen_string_literal: true

class SubscribeToHealthCenter
  def self.call(chat_id:, health_center_id:)
    new(chat_id, health_center_id).call
  end

  def initialize(chat_id, health_center_id)
    @chat_id = chat_id
    @health_center_id = health_center_id
  end

  def call
    chat = Chat.find_or_create_by(telegram_chat_id: @chat_id)
    begin
      chat.health_centers << HealthCenter.find(@health_center_id)
    rescue StandardError
      Rails.logger.debug 'registro já existe'
    end
  end
end
