# frozen_string_literal:true

class DataUpdaterWorker
  include Sidekiq::Worker

  def perform
    GovernmentApiService.call
  end
end
