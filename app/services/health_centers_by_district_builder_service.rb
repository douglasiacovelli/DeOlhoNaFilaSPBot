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
    health_centers = HealthCenter.where(district_id: @district_id).order(:name)
    health_center_options = health_centers.map do |health_center|
      {
        'text': health_center.name.capitalize,
        'callback_data': "#{NAMESPACE}:#{health_center.id}"
      }
    end

    health_center_options << {
      'text': '<< Voltar',
      'callback_data': "#{RegionsBuilderService::NAMESPACE}:#{health_centers.first.region_id}"
    }
    OptionsBuilderService.call(health_center_options)
  end
end
