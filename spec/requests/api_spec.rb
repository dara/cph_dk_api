require 'rails_helper'

RSpec.describe 'API', type: :request do
  let(:yesterdays_arrivals) do
    {
    }
  end

  let(:todays_departures) do
    {
    }
  end

  let(:valid_session) { {} }

  describe 'Search' do
    it 'returns 200' do
      get '/api/v1/search'
      expect(response).to have_http_status(200)
    end
  end

  describe 'bad URI' do
    it 'returns 404' do
      get '/api/v1/bad_uri'
      expect(response).to have_http_status(404)
    end
  end
end
