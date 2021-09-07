# frozen_string_literal: true

class HealthCenterStatusBuilderService
  def self.call(health_center)
    new(health_center).call
  end

  def initialize(health_center)
    @health_center = health_center
  end

  def call
    "Posto atualizado:\n"\
    "Posto: *#{@health_center.name.capitalize}*\n"\
    "Status: *#{@health_center.queue_size}*\n"\
    "Vacinas: *#{vaccines}*"
  end

  def vaccines
    vaccines_response = []
    vaccines_response << 'Coronavac' if @health_center.has_coronavac
    vaccines_response << 'Pfizer' if @health_center.has_pfizer
    vaccines_response << 'Astrazeneca' if @health_center.has_astrazeneca
    return 'Sem vacinas' if vaccines_response.empty?

    vaccines_response.join(',')
  end
end
