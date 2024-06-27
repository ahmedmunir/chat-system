class Chat < ApplicationRecord
  belongs_to :application, counter_cache: true
  has_many :messages, dependent: :destroy
  validates :number, presence: true, uniqueness: { scope: :application_id }

  before_validation :set_chat_number, on: :create

  private

  def set_chat_number
    if application
      max_number = application.chats.maximum(:number) || 0
      self.number = max_number + 1
    end
  end
end
