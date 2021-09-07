# frozen_string_literal: true

class HealthCenter < ApplicationRecord
  has_many :chat_subscriptions, dependent: :destroy
  has_many :chats, through: :chat_subscriptions
end
