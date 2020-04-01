# frozen_string_literal: true

require 'rails_helper'

require 'requests/auth_helper'

RSpec.configure do |c|
  c.include AuthHelper
end

RSpec.describe 'Movies', type: :request do
  before(:all) do
    signup_and_in
  end

  after(:all) do
    User.delete_all
  end

  def add_user_id (recordObject)
    recordObject["user_id"] = user_id
    recordObject
  end

  str = "30-Aug-2020"
  sample_date = str.to_date

  movie_params1 = { title: 'Movie 1', director: 'Director 1', year: sample_date }
  movie_params2 = { title: 'Movie 2', director: 'Director 2', year: sample_date }
  movie_params3 = { title: 'Movie 3', director: 'Director 3', year: sample_date }
  new_values = { title: 'New movie', director: 'New director', year: sample_date}

  def movies
    Movie.all
  end

  def movie_first
    Movie.first
  end

  def movie_last
    Movie.last
  end

  before(:all) do
    signup_and_in
    add_user_id (movie_params1)
    add_user_id (movie_params2)
    add_user_id (movie_params3)
    Movie.create!(movie_params1)
    Movie.create!(movie_params2)
    Movie.create!(movie_params3)
    add_user_id (new_values)
  end

  after(:all) do
    Movie.delete_all
  end

  describe 'GET /movies' do
    it 'lists all movies' do
      get '/movies', headers: headers
      expect(response).to be_success
      movies_response = JSON.parse(response.body)
      expect(movies_response["movies"].length).to eq(movies.count)
      expect(movies_response["movies"].first['title']).to eq(movie_first['title'])
    end
  end

  describe 'GET /movies/:id' do
    it 'shows one movie' do
      movie_id = movie_first['id']
      get "/movies/#{movie_id}", headers: headers
      expect(response).to be_successful

      json_response = JSON.parse(response.body)
      movie_response = json_response['movie']

      expect(movie_response['id']).not_to be_nil
      expect(movie_response['title']).to eq(movie_first['title'])
    end
  end

  describe 'DELETE /movies/:id' do
    it 'deletes an movie' do
      last_id = movie_last['id']
      delete "/movies/#{last_id}", headers: headers
      expect(response).to be_successful
      movie_exists = Movie.exists?(last_id)
      expect(movie_exists).to eq(false)
    end
  end

  describe 'PATCH /movies/:id' do
    def movie_diff
      { title: 'Updaded movie, only title updated' }
    end

    it 'updates an movie' do
      last_id = movie_last['id']
      patch "/movies/#{last_id}",
         params: { movie: movie_diff },
         headers: headers
      expect(response).to be_successful
    end
  end

  describe 'POST /movies' do
    it 'creates an movie' do
      post '/movies', params: { movie: new_values }, headers: headers
      expect(response).to be_successful
      last_record = Movie.last
      expect(last_record['title']).to eq(new_values[:title])
    end
  end
end
