# frozen_string_literal: true

class RegionsBuilderService
  NAMESPACE_LIST_REGIONS = 'list_regions'
  NAMESPACE = 'region'

  def self.call
    new.call
  end

  def call
    regions = HealthCenter.distinct.order(:region).pluck('region', 'region_id').map do |name, id|
      {
        'text': region_name(name).capitalize,
        'callback_data': "#{NAMESPACE}:#{id}"
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
