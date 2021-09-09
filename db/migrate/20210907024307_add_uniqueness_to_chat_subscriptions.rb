class AddUniquenessToChatSubscriptions < ActiveRecord::Migration[6.1]
  def change
    add_index :chat_subscriptions, %i[chat_id health_center_id], unique: true
  end
end
