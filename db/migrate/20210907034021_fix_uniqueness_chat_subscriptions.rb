class FixUniquenessChatSubscriptions < ActiveRecord::Migration[6.1]
  def change
    remove_index :chat_subscriptions, :chat_id
    add_index :chat_subscriptions, [:chat_id, :health_center_id], unique: true
  end
end
