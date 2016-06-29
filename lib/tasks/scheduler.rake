namespace :scheduler do
  task run: :environment do
    ScraperService.call
  end
end
