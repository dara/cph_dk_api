require 'rails_helper'

RSpec.describe ApiController, type: :routing do
  describe 'routing' do
    it 'routes to #search' do
      expect(get: '/api/v1/search').to route_to('api#search')
    end

    it 'routes to #not_found' do
      expect(get: '/api/v1/bad_uri').to route_to(
        controller: 'api',
        action: 'not_found',
        path: 'api/v1/bad_uri'
      )
    end
  end
end
