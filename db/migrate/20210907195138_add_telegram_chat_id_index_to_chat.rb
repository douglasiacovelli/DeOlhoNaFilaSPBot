class AddTelegramChatIdIndexToChat < ActiveRecord::Migration[6.1]
  def change
    add_index :chats, :telegram_chat_id, unique: true
  end
end
