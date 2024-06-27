class MessagesController < ApplicationController
  def index
    application = Application.find_by(token: params[:application_token])
    if application
      chat = application.chats.find_by(number: params[:chat_number])
      if chat
        messages = chat.messages
        render json: messages
      else
        render json: { error: 'Chat not found' }, status: :not_found
      end
    else
      render json: { error: 'Application not found' }, status: :not_found
    end
  end

  def create
    application = Application.find_by(token: params[:application_token])
    if application
      puts "Application found"
      application.chats.each do |chat|
        puts "Chat number: #{chat.number}"
      end
      puts "Chat number: #{params[:chat_number]}"
      chat = application.chats.find_by(number: params[:chat_number])
      if chat
        message = chat.messages.create(message_params)
        if message.persisted?
          render json: { number: message.number, chat_number: chat.number, application_token: application.token }, status: :created
        else
          render json: message.errors, status: :unprocessable_entity
        end
      else
        render json: { error: 'Chat not found' }, status: :not_found
      end
    else
      render json: { error: 'Application not found' }, status: :not_found
    end
  end

  def search
    application = Application.find_by(token: params[:application_token])
    if application
      chat = application.chats.find_by(number: params[:chat_number])
      if chat
        messages = Message.search({
          query: {
            bool: {
              must: [
                { match: { chat_id: chat.id } },
                { match: { body: params[:query] } }
              ]
            }
          }
        }).records
        render json: messages
      else
        render json: { error: 'Chat not found' }, status: :not_found
      end
    else
      render json: { error: 'Application not found' }, status: :not_found
    end
  end  

  private

  def message_params
    params.require(:message).permit(:body)
  end
end
