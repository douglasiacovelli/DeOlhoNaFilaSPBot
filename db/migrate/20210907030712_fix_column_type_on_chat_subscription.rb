class FixColumnTypeOnChatSubscription < ActiveRecord::Migration[6.1]
  def change
    change_column :chat_subscriptions, :health_center_id, 'int USING CAST(health_center_id AS integer)', references: :health_centers
  end
end
