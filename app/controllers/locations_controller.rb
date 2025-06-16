class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :update, :destroy]

  # GET /locations.json or /locations
  def index
    @locations = Location.all

    render json: @locations.select(:id, :name, :created_at, :updated_at), status: :ok
  end

  # GET /locations/:id.json
  def show
    render json: @location, status: :ok
  end

  # POST /locations.json
  def create
    @location = Location.new(location_params)
    if @location.save
      render json: @location, status: :created
    else
      render json: { errors: @location.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT/PATCH /locations/:id.json
  def update
    if @location.update(location_params)
      render json: @location, status: :ok
    else
      render json: { errors: @location.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /locations/:id.json
  def destroy
    @location.destroy
    render json: { message: 'Location deleted' }, status: :ok
  end

  private

  def set_location
    @location = Location.find_by(id: params[:id])
    unless @location
      render json: { error: 'Location not found' }, status: :not_found
    end
  end

  def location_params
    params.require(:location).permit(:name)
  end
end

