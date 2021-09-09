# frozen_string_literal: true

require 'faraday'
require 'faraday_middleware'

class GovernmentApiService
  def self.call
    new.call
  end

  def initialize
    @faraday = Faraday.new(
      url: Rails.configuration.government_api_url
    ) do |f|
      f.response :json
    end
  end

  def call
    response = @faraday.post('', 'dados=dados')
    return if response.body.blank?

    response.body.each do |health_center|
      health_center_data = health_center_hash(health_center)
      cached_health_center = HealthCenter.find_by(id: health_center['id_tb_unidades'].to_i)

      if cached_health_center.nil?
        Rails.logger.debug 'no cached health center. Creating'
        HealthCenter.create(health_center_data)
        notify_health_center_changed health_center_data[:id]
      elsif stale_cache?(cached_health_center, health_center_data)
        Rails.logger.debug 'stale cache. Updating'
        cached_health_center.update(health_center_data)
        notify_health_center_changed health_center_data[:id]
      else
        Rails.logger.debug 'cache up to date'
      end
    end
    nil
  end

  private

  def stale_cache?(cached_health_center, health_center_data)
    cached_health_center.last_updated_at < HealthCenter.new(health_center_data).last_updated_at
  end

  def notify_health_center_changed(health_center_id)
    @notify_health_center_updated_service ||= NotifyHealthCenterUpdatedService.new
    @notify_health_center_updated_service.call(health_center_id)
  end

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def health_center_hash(health_center)
    {
      id: health_center['id_tb_unidades'].to_i,
      name: health_center['equipamento'].downcase,
      address: health_center['endereco'].downcase,
      region: health_center['crs'].downcase,
      region_id: health_center['id_crs'].to_i,
      district: health_center['distrito'].downcase,
      district_id: health_center['id_distrito'].to_i,
      queue_size: health_center['status_fila'].downcase,
      has_coronavac: health_center['coronavac'] == '1',
      has_pfizer: health_center['pfizer'] == '1',
      has_astrazeneca: health_center['astrazeneca'] == '1',
      last_updated_at: DateTime.parse("#{health_center['data_hora']}-0300")
    }
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength
end
