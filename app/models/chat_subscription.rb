# frozen_string_literal: true

class ChatSubscription < ApplicationRecord
  validates :chat_id, uniqueness: { scope: :health_center_id }
  belongs_to :chat
  belongs_to :health_center
end
