# frozen_string_literal: true

class UpdatesController < ApplicationController
  def index
    if list_regions?
      send_regions
    elsif region_selected?
      send_districts_by_region
    elsif district_selected?
      send_health_centers
    elsif health_center_selected?
      subscribe_to_health_center
    end

    head :no_content
  end

  private

  def send_health_centers
    district_id = callback_data[:value]
    SendMessageService.call(
      chat_id: chat_id,
      message_payload: HealthCentersByDistrictBuilderService.call(district_id),
      text: 'Escolha o posto de saúde'
    )
  end

  def send_regions
    SendMessageService.call(
      chat_id: chat_id,
      message_payload: RegionsBuilderService.call,
      text: 'Escolha a região do posto'
    )
  end

  def send_districts_by_region
    region_id = callback_data[:value]
    SendMessageService.call(
      chat_id: chat_id,
      message_payload: DistrictsByRegionBuilderService.call(region_id),
      text: 'Escolha o bairro do posto'
    )
  end

  def subscribe_to_health_center
    health_center_id = callback_data[:value]
    SubscribeToHealthCenter.call(chat_id: chat_id, health_center_id: health_center_id)
    SendMessageService.call(
      chat_id: chat_id,
      text: 'Posto selecionado\! Agora você ficará sabendo das atualizações'
    )
    SendMessageService.call(
      chat_id: chat_id,
      text: HealthCenterStatusBuilderService.call(HealthCenter.find(health_center_id))
    )
  end

  def list_regions?
    return false if message_object['text'].blank?

    message_object['text'].starts_with?('/listarpostos')
  end

  def district_selected?
    callback_data[:namespace] == DistrictsByRegionBuilderService::NAMESPACE
  end

  def region_selected?
    callback_data[:namespace] == RegionsBuilderService::NAMESPACE
  end

  def health_center_selected?
    callback_data[:namespace] == HealthCentersByDistrictBuilderService::NAMESPACE
  end

  def callback_data
    return {} if params['callback_query'].blank?

    callback_values = params['callback_query']['data'].split(':')
    {
      namespace: callback_values[0],
      value: callback_values[1]
    }
  end

  def chat_id
    message_object['chat']['id']
  end

  def message_object
    if params['callback_query'].present?
      params['callback_query']['message']
    elsif params['edited_message'].present?
      params['edited_message']
    else
      params['message']
    end
  end
end