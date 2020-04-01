require_relative '../../lib/debug_helper'
include DebugHelper

# Template instruction: decide between ProtectedController and OpenReadControler
class MoviesController < ProtectedController
  # Template instruction: decide if you wan
  before_action :set_movie, only: [:show, :update, :destroy]

  # GET /movies
  def index
    # Template instruction: decide if you want restricted or unrestricted listing
    # Template instructions: decide if you want unrestricted access
    # Below statement gives you unrestricted
    # @movie = movies.all
    # Below gives you restricted
    @movies = current_user.movies.all

    render json: @movies
  end

  # GET /movies/1
  def show
    # Template instructions: decide if you want unrestricted access
    # Below statement gives you unrestricted
    # @movie = movies.find(params[:id])
    # Below gives you restricted
    @movie = current_user.movies.find(params[:id])

    render json: @movie

  end

  # POST /movies
  def create
    # Template instructions: Add this line to include user id if related to user
    @movie = current_user.movies.build(movie_params)
    # Template instructions: If not related to  user, leave as below
    # @movie = Movie.new(movie_params)

    if @movie.save
      render json: @movie, status: :created, location: @movie
    else
      render json: @movie.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /movies/1
  def update
    if @movie.update(movie_params)
      render json: @movie
    else
      render json: @movie.errors, status: :unprocessable_entity
    end
  end

  # DELETE /movies/1
  def destroy
    @movie.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def movie_params
      params.require(:movie).permit(:title, :director, :year, :user_id)
    end
end
