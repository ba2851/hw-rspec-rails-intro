require 'rails_helper'

describe MoviesController, type: :controller do
  it 'displays an error when the title is missing' do
    expect(Movie).not_to receive(:find_in_tmdb)

    post :search_tmdb, params: {
      title: '',
      release_year: '1986',
      language: 'all'
    }

    expect(flash.now[:danger]).to eq('Please fill in all required fields!')
  end

  it 'displays an error when no movies are found' do
    allow(Movie).to receive(:find_in_tmdb).and_return([])

    post :search_tmdb, params: {
      title: 'Nonexistent Movie',
      language: 'all'
    }

    expect(flash.now[:warning]).to eq('No movies found with given parameters!')
  end
end
