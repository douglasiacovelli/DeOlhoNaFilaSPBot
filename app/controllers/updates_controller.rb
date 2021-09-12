# frozen_string_literal: true

class UpdatesController < ApplicationController
  # rubocop:disable Metrics/MethodLength
  def index
    if start?
      send_welcome_message
    elsif list_regions?
      send_regions
    elsif list_regions_again?
      send_regions(edit: true)
    elsif region_selected?
      send_districts_by_region
    elsif district_selected?
      send_health_centers
    elsif health_center_selected?
      subscribe_to_health_center
    end

    head :no_content
  end
  # rubocop:enable Metrics/MethodLength

  private

  def send_health_centers
    district_id = callback_data[:value]
    SendMessageService.call(
      service_chat_id: chat_id,
      message_payload: HealthCentersByDistrictBuilderService.call(district_id),
      text: 'Escolha o posto de saúde',
      edit_message: true
    )
  end

  def send_regions(edit: false)
    SendMessageService.call(
      service_chat_id: chat_id,
      message_payload: RegionsBuilderService.call,
      text: 'Escolha a região do posto',
      save_message_id: !edit,
      edit_message: edit
    )
  end

  def send_districts_by_region
    region_id = callback_data[:value]
    SendMessageService.call(
      service_chat_id: chat_id,
      message_payload: DistrictsByRegionBuilderService.call(region_id),
      text: 'Escolha o bairro do posto',
      edit_message: true
    )
  end

  # rubocop:disable Style/StringLiterals
  def send_welcome_message
    SendMessageService.call(
      service_chat_id: chat_id,
      text: "Olá\\!\nEu sou um bot para que você saiba sempre que um posto de saúde for *atualizado*\\!"\
            "\n\nMeus comandos são:\n\n\/listarpostos\ para que você selecione os postos\\.\n\n"\
            "No futuro vou ficar um pouco mais espertinho :\\)\n\n"\
            "Se gostar de mim, compartilha com seus amigos pra ajudá\\-los também"
    )
  end
  # rubocop:enable Style/StringLiterals

  def subscribe_to_health_center
    health_center_id = callback_data[:value]
    SubscribeToHealthCenter.call(chat_id: chat_id, health_center_id: health_center_id)
    SendMessageService.call(
      service_chat_id: chat_id,
      text: 'Posto selecionado\! Agora você ficará sabendo das atualizações',
      edit_message: true
    )
    SendMessageService.call(
      service_chat_id: chat_id,
      text: HealthCenterStatusBuilderService.call(HealthCenter.find(health_center_id))
    )
  end

  def start?
    message_object['text'].starts_with?('/start')
  end

  def list_regions?
    return false if message_object['text'].blank?

    message_object['text'].starts_with?('/listarpostos')
  end

  def list_regions_again?
    callback_data[:namespace] == RegionsBuilderService::NAMESPACE_LIST_REGIONS
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
