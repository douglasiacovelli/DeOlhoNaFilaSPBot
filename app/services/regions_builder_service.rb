# frozen_string_literal: true

class RegionsBuilderService
  NAMESPACE = 'region'

  def self.call
    new.call
  end

  def call
    regions = HealthCenter.distinct.pluck('region').map do |region|
      {
        'text': region_name(region).capitalize,
        'callback_data': "#{NAMESPACE}:#{region}"
      }
    end
    OptionsBuilderService.call(regions)
  end

  def region_name(region)
    if region == 'mega-drives'
      'Mega postos/Drive-thru'
    else
      region
    end
  end
end
