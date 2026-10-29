class Movie < ActiveRecord::Base
  def self.find_in_tmdb(search_terms)
    url = 'https://api.themoviedb.org/3/search/movie'
    query = search_terms.is_a?(Hash) ? search_terms : {title: search_terms}

    response = Faraday.get(url, {
      api_key: ENV['TMDB_API_KEY'],
      query: query[:title],
      language: query[:language] || 'en-US',
      year: query[:release_year]
    }.compact)

    return [] unless response.success?

    JSON.parse(response.body).fetch('results', []).map do |result|
      Movie.new(
        title: result['title'],
        description: result['overview'],
        release_date: result['release_date'].presence,
        rating: 'R'
      )
    end
  end

  def self.all_ratings
    %w[G PG PG-13 R]
  end

  def self.with_ratings(ratings, sort_by)
    if ratings.nil?
      all.order sort_by
    else
      where(rating: ratings.map(&:upcase)).order sort_by
    end
  end
end
