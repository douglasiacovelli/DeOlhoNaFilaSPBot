class MakeChatIdAReferenceOnChatSubscriptions < ActiveRecord::Migration[6.1]
  def change
    change_column :chat_subscriptions, :chat_id, :int, references: :chats
    remove_column :chat_subscriptions, :active
  end
end
