class DestroysController < ApplicationController
  before_action :set_destroy, only: [:show, :update, :destroy]

  # GET /destroys
  def index
    @destroys = Destroy.all

    render json: @destroys
  end

  # GET /destroys/1
  def show
    render json: @destroy
  end

  # POST /destroys
  def create
    @destroy = Destroy.new(destroy_params)

    if @destroy.save
      render json: @destroy, status: :created, location: @destroy
    else
      render json: @destroy.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /destroys/1
  def update
    if @destroy.update(destroy_params)
      render json: @destroy
    else
      render json: @destroy.errors, status: :unprocessable_entity
    end
  end

  # DELETE /destroys/1
  def destroy
    @destroy.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_destroy
      @destroy = Destroy.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def destroy_params
      params.require(:destroy).permit(:Example)
    end
end
