class FixColumnTypeOnChatSubscription < ActiveRecord::Migration[6.1]
  def change
    change_column :chat_subscriptions, :health_center_id, :int, references: :health_centers
  end
end