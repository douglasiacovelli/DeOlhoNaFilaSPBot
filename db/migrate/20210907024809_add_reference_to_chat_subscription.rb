class AddReferenceToChatSubscription < ActiveRecord::Migration[6.1]
  def up
    change_table :chat_subscriptions, bulk: true do |t|
      t.remove :health_center_id
      t.string :health_center_id, references: :health_centers
    end
  end

  def down
    change_table :chat_subscriptions, bulk: true do |t|
      t.remove :health_center_id
      t.string :health_center_id, :string
    end
  end
end
