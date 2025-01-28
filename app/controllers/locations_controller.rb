class LocationsController < ApplicationController
  before_action :set_location, only: %i[show edit update destroy]

  # GET /locations or /locations.json
  def index
    @locations = Location.all
    respond_with_format(@locations)
  end

  # GET /locations/:id or /locations/:id.json
  def show
    @customers = @location.customers
    respond_with_format({ location: @location, customers: @customers })
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # POST /locations or /locations.json
  def create
    @location = Location.new(location_params)

    if @location.save
      render_success("Location created successfully!", @location, :created)
    else
      render_error(@location.errors.full_messages, :unprocessable_entity)
    end
  end

  # GET /locations/:id/edit
  def edit
  end

  # PATCH/PUT /locations/:id or /locations/:id.json
  def update
    if @location.update(location_params)
      render_success("Location updated successfully!", @location, :ok)
    else
      render_error(@location.errors.full_messages, :unprocessable_entity)
    end
  end

  # DELETE /locations/:id or /locations/:id.json
  def destroy
    @location.destroy
    render_success("Location deleted successfully!", nil, :ok)
  end

  private

  # Set location for actions requiring a specific location
  def set_location
    @location = Location.find(params[:id])
  end

  # Permit only safe parameters
  def location_params
    params.require(:location).permit(:name)
  end

  # Utility for consistent JSON responses
  def render_success(message, data = nil, status)
    response = { message: message }
    response[:data] = data if data
    render json: response, status: status
  end

  def render_error(errors, status)
    render json: { errors: errors }, status: status
  end

  # Automatically respond with HTML or JSON based on the request
  def respond_with_format(data)
    respond_to do |format|
      format.html # Defaults to rendering the respective HTML view
      format.json { render json: data }
    end
  end
end


