require 'open-uri'

class ScraperService
  class << self
    BASE_URL = 'https://www.cph.dk/en/flight-info'.freeze
    ROW_SELECTOR = 'table.info-table tbody tr'.freeze
    ARRIVALS = 'arrivals'.freeze
    DEPARTURES = 'departures'.freeze
    CPH = 'Copenhagen'.freeze

    def call
      %w(arrivals departures).each do |direction|
        %w(today tomorrow yesterday).each do |date|
          scrape = Scrape.where(date: date, direction: direction).take
          scrape.update(data: fetch_html(direction, date))
        end
      end
    end

    def fetch_html(direction, date)
      html = Nokogiri::HTML(open(build_url(date, direction)))
      html.css(ROW_SELECTOR).each_with_index.map do |row, i|
        parse_row(row, i, date, direction)
      end
    end

    def word_to_time(date, time = '0:00')
      case date
      when 'today'
        Time.zone.parse(time)
      when 'yesterday'
        Time.zone.parse(time) - 1.day
      when 'tomorrow'
        Time.zone.parse(time) + 1.day
      end
    end

    def build_url(date, direction)
      formatted_date = word_to_time(date).strftime('%-m/%d/%Y')
      "#{BASE_URL}/#{direction}1/?showAll=True&selectedDate=#{formatted_date}&showAllResults=True"
    end

    def parse_row(row, i, date, direction)
      {
        id: i + 1,
        timestamp: timestamp(date, row),
        scheduled_time: scheduled_time(row),
        delayed_time: delayed_time(row),
        airline: airline(row),
        from: from(row, direction),
        to: to(row, direction),
        flight_number: flight_number(row),
        gate: gate(row),
        status: status(row)
      }
    end

    def timestamp(date, row)
      time = row.css('td.scheduled-time span')[0].text.strip
      word_to_time(date, time).to_i
    end

    def scheduled_time(row)
      row.css('td.scheduled-time span')[0].text.strip
    end

    def delayed_time(row)
      time = row.css('td.delayed-time').text.strip
      return time if time.present?
    end

    def airline(row)
      row.css('td.airlines').text.strip
    end

    def from(row, direction)
      direction == ARRIVALS ? row.css('td strong.destination').text.strip : CPH
    end

    def to(row, direction)
      direction == DEPARTURES ? row.css('td strong.destination').text.strip : CPH
    end

    def flight_number(row)
      # row.css('td.flight-destin .flight-num span').map(&:text)
      row.css('td.flight-destin .flight-num span')[0].text
    end

    def gate(row)
      row.css('td[title="Gate"]').first.try(:text)
    end

    def status(row)
      row.css('span.flight-label').first.try(:text)
    end
  end
end
