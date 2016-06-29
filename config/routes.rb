Rails.application.routes.draw do
  scope '/api' do
    scope '/v1' do
      scope '/search' do
        get '/' => 'api#search'
      end
    end
  end

  match "*path", to: "api#not_found", via: :all
end 
