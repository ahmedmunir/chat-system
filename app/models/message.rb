class Message < ApplicationRecord
  belongs_to :chat, counter_cache: true
  validates :number, presence: true, uniqueness: { scope: :chat_id }
  validates :body, presence: true

  before_validation :set_message_number, on: :create

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  settings index: { number_of_shards: 1 } do
    mappings dynamic: false do
      indexes :body, type: :text, analyzer: 'english'
      indexes :chat_id, type: :integer
    end
  end

  def as_indexed_json(options = {})
    as_json(only: [:body, :chat_id])
  end

  private

  def set_message_number
    if chat
      max_number = chat.messages.maximum(:number) || 0
      self.number = max_number + 1
    end
  end
end

# Ensure the index is created and existing records are indexed
Message.__elasticsearch__.create_index! force: true
Message.import
