class CreateChatSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :chat_subscriptions do |t|
      t.string :chat_id
      t.boolean :active

      t.timestamps
    end
  end
end
