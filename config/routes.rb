Rails.application.routes.draw do
  root to: 'scraping#new'
  post '/', to: 'scraping#new'
end
