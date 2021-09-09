# frozen_string_literal:true

require 'sidekiq-scheduler'
class DataUpdaterWorker
  include Sidekiq::Worker

  def perform
    GovernmentApiService.call
  end
end
