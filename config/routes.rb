Rottenpotatoes::Application.routes.draw do
  get '/search', to: 'movies#search_tmdb', as: 'search_tmdb'
  post '/search', to: 'movies#search_tmdb', as: 'submit_tmdb_search'
  post '/add_movie', to: 'movies#add_movie', as: 'add_movie'
  resources :movies
  # map '/' to be a redirect to '/movies'
  root to: redirect('/movies')
end
