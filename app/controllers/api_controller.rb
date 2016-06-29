class ApiController < ApplicationController
  before_action :allow_cross_origin_requests

  def search
    return not_found if date.blank? || direction.blank?
    flights = Scrape.where(date: date, direction: direction).take
    render json: flights.data
  end

  def not_found
    render json: { 'error': 'not found' }, status: 404
  end

  private

  def allow_cross_origin_requests
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Methods'] = 'GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With,
      Content-Type, Accept, Authorization'
    headers['Access-Control-Max-Age'] = '1728000'
  end

  def date
    %w(today tomorrow yesterday).include?(params['date']) ? params['date'] : nil
  end

  def direction
    %w(arrivals departures).include?(params['direction']) ? params['direction'] : nil
  end
end
