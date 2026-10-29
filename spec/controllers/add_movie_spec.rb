require 'rails_helper'

describe MoviesController, type: :controller do
  describe 'adding a movie' do
    it 'saves the movie and redirects to search' do
      movie_params = {
        title: 'Test Movie',
        rating: 'R',
        description: 'Test',
        release_date: '2020-01-01'
      }

      expect {
        post :add_movie, params: {movie: movie_params}
      }.to change(Movie, :count).by(1)

      expect(response).to redirect_to(search_tmdb_path)
      expect(flash[:notice]).to eq(
        'Test Movie was successfully added to RottenPotatoes.'
      )
    end
  end
end
