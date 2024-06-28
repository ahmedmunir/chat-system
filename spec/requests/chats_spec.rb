require 'rails_helper'

RSpec.describe "Chats", type: :request do
  let!(:application) { create(:application) }
  let(:application_token) { application.token }
  let!(:chat) { create(:chat, application: application) }
  let(:chat_number) { chat.number }

  # Define a helper method to parse the response body to JSON
  def json
    JSON.parse(response.body)
  end

  describe "GET /applications/:application_token/chats" do
    before { get "/applications/#{application_token}/chats" }

    it "returns chats" do
      expect(json).not_to be_empty
      expect(json.size).to eq(1)
    end

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /applications/:application_token/chats" do
    let(:valid_attributes) { { some_attribute: 'value' } } # Adjust as necessary

    before { post "/applications/#{application_token}/chats", params: { chat: valid_attributes } } # Adjust if your API does not expect params

    it "creates a chat" do
      expect(json['number']).to eq(2)
    end

    it "returns status code 201" do
      expect(response).to have_http_status(201)
    end
  end
end