require 'rails_helper'

describe MoviesController, type: :controller do
  render_views

  it 'displays TMDb search results with Add Movie buttons' do
    movies = [
      Movie.new(title: 'Manhunter', rating: 'R',
                release_date: Date.new(1986, 8, 15),
                description: 'Crime thriller')
    ]

    allow(Movie).to receive(:find_in_tmdb).and_return(movies)

    post :search_tmdb, params: {
      title: 'Manhunter',
      release_year: '1986',
      language: 'all'
    }

    expect(response.body).to include('search_movies')
    expect(response.body).to include('Manhunter')
    expect(response.body).to include('Add Movie')
  end
end
