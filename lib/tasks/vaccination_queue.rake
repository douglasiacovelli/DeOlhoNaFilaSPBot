# frozen_string_literal: true

namespace :vaccination_queue do
  desc 'Fetch data'
  task fetch_data: :environment do
    GovernmentApiService.call
  end
end
