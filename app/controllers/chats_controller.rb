class ChatsController < ApplicationController
  def index
    application = Application.find_by(token: params[:application_token])
    if application
      chats = application.chats
      render json: chats
    else
      render json: { error: 'Application not found' }, status: :not_found
    end
  end

  def create
    application = Application.find_by(token: params[:application_token])
    if application
      chat = application.chats.create
      if chat.persisted?
        render json: { number: chat.number, application_token: application.token }, status: :created
      else
        render json: chat.errors, status: :unprocessable_entity
      end
    else
      render json: { error: 'Application not found' }, status: :not_found
    end
  end
end
