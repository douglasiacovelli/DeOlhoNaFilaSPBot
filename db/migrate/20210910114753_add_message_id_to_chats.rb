# frozen_string_literal: true

class AddMessageIdToChats < ActiveRecord::Migration[6.1]
  def change
    add_column :chats, :message_id, :integer
  end
end
