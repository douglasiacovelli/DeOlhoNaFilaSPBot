# frozen_string_literal: true

class HealthCentersByRegionBuilderService
  NAMESPACE = 'health_center'

  def self.call(region)
    new(region).call
  end

  def initialize(region)
    @region = region
  end

  def call
    regions = HealthCenter.where(region: @region).order(:name).map do |health_center|
      {
        'text': health_center.name.capitalize,
        'callback_data': "#{NAMESPACE}:#{health_center.id}"
      }
    end
    OptionsBuilderService.call(regions)
  end
end
