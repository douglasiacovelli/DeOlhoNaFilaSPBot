class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats do |t|
      t.string :telegram_chat_id
      t.boolean :active

      t.timestamps
    end
  end
end
