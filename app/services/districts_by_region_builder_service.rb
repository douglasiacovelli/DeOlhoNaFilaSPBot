# frozen_string_literal: true

class DistrictsByRegionBuilderService
  NAMESPACE = 'district'

  def self.call(region_id)
    new(region_id).call
  end

  def initialize(region_id)
    @region_id = region_id
  end

  def call
    districts = HealthCenter
                .distinct
                .where(region_id: @region_id)
                .pluck('district', 'district_id').map do |name, id|
                  {
                    'text': name.capitalize,
                    'callback_data': "#{NAMESPACE}:#{id}"
                  }
                end
    OptionsBuilderService.call(districts)
  end
end
