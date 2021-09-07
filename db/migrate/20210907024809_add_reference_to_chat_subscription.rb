class AddReferenceToChatSubscription < ActiveRecord::Migration[6.1]
  def change
    remove_column :chat_subscriptions, :health_center_id
    add_column :chat_subscriptions, :health_center_id, :string, references: :health_centers
  end
end
