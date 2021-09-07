# frozen_string_literal: true

class Chat < ApplicationRecord
  has_many :chat_subscriptions, dependent: :destroy
  has_many :health_centers, through: :chat_subscriptions
  validates :telegram_chat_id, uniqueness: true
end
