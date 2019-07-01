Rails.application.routes.draw do
  root to: 'scraping#new'
  post '/get_url', to: 'scraping#create'
end
