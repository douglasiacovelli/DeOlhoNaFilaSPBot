class MakeChatIdAReferenceOnChatSubscriptions < ActiveRecord::Migration[6.1]
  def change
    change_table :chat_subscriptions, bulk: true do |t|
      t.change_column :chat_subscriptions,
                      :chat_id,
                      'integer USING CAST(chat_id AS integer)',
                      references: :chats
      t.remove_column :chat_subscriptions, :active, :boolean
    end
  end
end
