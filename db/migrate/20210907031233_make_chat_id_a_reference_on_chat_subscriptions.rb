class MakeChatIdAReferenceOnChatSubscriptions < ActiveRecord::Migration[6.1]
  def up
    change_table :chat_subscriptions, bulk: true do |t|
      t.remove :chat_id
      t.integer :chat_id, references: :chats
      t.remove :active
    end
  end

  def down
    change_table :chat_subscriptions, bulk: true do |t|
      t.remove :chat_id
      t.string :chat_id
      t.boolean :active
    end
  end
end
