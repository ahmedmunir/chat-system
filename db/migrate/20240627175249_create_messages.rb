class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.references :chat, null: false, foreign_key: true
      t.integer :number
      t.text :body

      t.timestamps
    end
    add_index :messages, [:chat_id, :number], unique: true
    add_index :messages, :body, length: 255
  end
end
