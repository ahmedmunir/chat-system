require 'rails_helper'

RSpec.describe "Messages", type: :request do
  let!(:application) { create(:application) }
  let(:application_token) { application.token }
  let!(:chat) { create(:chat, application: application) }
  let(:chat_number) { chat.number }
  let!(:message) { create(:message, chat: chat) }
  let(:message_number) { message.number }

  # Define a helper method to parse the response body to JSON
  def json
    JSON.parse(response.body)
  end

  describe "GET /applications/:application_token/chats/:chat_number/messages" do
    before { get "/applications/#{application_token}/chats/#{chat_number}/messages" }

    it "returns messages" do
      expect(json).not_to be_empty
      expect(json.size).to eq(1)
    end

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /applications/:application_token/chats/:chat_number/messages" do
    let(:valid_attributes) { { body: 'Hello, World!' } }

    context "when the request is valid" do
      before { post "/applications/#{application_token}/chats/#{chat_number}/messages", params: { message: valid_attributes } }

      it "creates a message" do
        message = chat.messages.find_by(number: json['number'])
        expect(message.body).to eq('Hello, World!')
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end

    context "when the request is invalid" do
      before { post "/applications/#{application_token}/chats/#{chat_number}/messages", params: { message: { body: '' } } }

      it "returns status code 422" do
        expect(response).to have_http_status(422)
      end
    end
  end
end