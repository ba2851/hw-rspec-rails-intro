require 'spec_helper'
require 'rails_helper'

describe Movie do
  describe 'searching Tmdb by keyword' do
    it 'calls Faraday gem with CS169 domain' do
      expect(Faraday).to receive(:get).and_call_original
      Movie.find_in_tmdb('https://cs169.org')
    end
    it 'calls Tmdb with valid API key' do
      Movie.find_in_tmdb({title: "hacker", language: "en"})
    end
  end
end

describe Movie, type: :model do
  it 'converts TMDb results into unsaved Movie objects' do
    movies = Movie.find_in_tmdb(title: 'Olympics', language: 'en')

    expect(movies.length).to eq(2)
    expect(movies.first).to be_a(Movie)
    expect(movies.first).not_to be_persisted
    expect(movies.first.title).to eq('Sydney 2000 Olympics Opening Ceremony')
    expect(movies.first.rating).to eq('R')
    expect(movies.first.release_date.to_date).to eq(Date.new(2000, 9, 15))
  end
end
