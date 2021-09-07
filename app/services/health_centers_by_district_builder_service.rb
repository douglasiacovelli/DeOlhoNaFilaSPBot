# frozen_string_literal: true

class HealthCentersByDistrictBuilderService
  NAMESPACE = 'health_center'

  def self.call(district_id)
    new(district_id).call
  end

  def initialize(district_id)
    @district_id = district_id
  end

  def call
    health_centers = HealthCenter
                     .where(district_id: @district_id)
                     .order(:name)
                     .map do |health_center|
      {
        'text': health_center.name.capitalize,
        'callback_data': "#{NAMESPACE}:#{health_center.id}"
      }
    end
    OptionsBuilderService.call(health_centers)
  end
end
