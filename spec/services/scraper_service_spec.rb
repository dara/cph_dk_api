require 'rails_helper'

RSpec.describe ScraperService do
  describe 'self.call' do
    it 'parses departures for a given day' do
      stub_request(:get, 'https://www.cph.dk/en/flight-info/departures1/?selectedDate=06/14/2016&showAll=True&showAllResults=True')
        .to_return(status: 200, body: IO.read(
          Rails.root.join('spec', 'data', 'departures.html')
        ), headers: {})
      puts ScraperService.call('2016-06-14'.to_date, 'departures')
    end

    it 'parses arrivals for a given day' do
    end

    it 'fails with invalid parameters' do
    end
  end
end
