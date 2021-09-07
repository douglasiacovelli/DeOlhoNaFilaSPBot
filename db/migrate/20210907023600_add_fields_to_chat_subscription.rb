class AddFieldsToChatSubscription < ActiveRecord::Migration[6.1]
  def change
    add_column :chat_subscriptions, :health_center_id, :string
  end
end
