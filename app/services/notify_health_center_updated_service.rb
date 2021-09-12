# frozen_string_literal: true

class NotifyHealthCenterUpdatedService
  def self.call(health_center_id)
    new.call(health_center_id)
  end

  def call(health_center_id)
    health_center = HealthCenter.find(health_center_id)
    health_center.chat_subscriptions.each do |chat_subscription|
      SendMessageService.call(
        service_chat_id: chat_subscription.chat.telegram_chat_id,
        text: HealthCenterStatusBuilderService.call(health_center)
      )
    end
  end

  def vaccines(health_center)
    vaccines_response = []
    vaccines << 'Coronavac' if health_center.has_coronavac
    vaccines << 'Pfizer' if health_center.has_pfizer
    vaccines << 'Astrazeneca' if health_center.has_astrazeneca
    response = vaccines_response.join(', ')
    return 'Sem vacinas' if response.blank?
  end
end
