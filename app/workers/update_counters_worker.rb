class UpdateCountersWorker
    include Sidekiq::Worker
  
    def perform
      Application.find_each do |application|
        application.update(chats_count: application.chats.size)
        application.chats.find_each do |chat|
          chat.update(messages_count: chat.messages.size)
        end
      end
    end
  end
  