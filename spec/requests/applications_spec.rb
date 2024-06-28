require 'rails_helper'

RSpec.describe "Applications", type: :request do
  let!(:application) { create(:application) }
  let(:application_id) { application.id }

  # Helper method to parse response body
  def json
    JSON.parse(response.body)
  end

  describe "GET /applications/:token" do
    before { get "/applications/#{application.token}" }

    it "returns the application" do
      expect(json).not_to be_empty
      expect(json['id']).to eq(application.id)
    end

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /applications" do
    let(:valid_attributes) { { name: 'My Application' } }

    context "when the request is valid" do
      before { post "/applications", params: { application: valid_attributes } }

      it "creates an application" do
        expect(json['name']).to eq('My Application')
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end

    context "when the request is invalid" do
      before { post "/applications", params: { application: { name: '' } } }

      it "returns status code 422" do
        expect(response).to have_http_status(422)
      end
    end
  end
end