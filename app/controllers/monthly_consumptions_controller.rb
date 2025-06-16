class MonthlyConsumptionsController < ApplicationController
  before_action :set_customer, only: %i[index new create]
  before_action :set_monthly_consumption, only: %i[show edit update destroy]

  # GET /locations/:location_id/customers/:customer_id/monthly_consumptions
  def index
    @monthly_consumptions = @customer.monthly_consumptions

    respond_to do |format|
      format.html
      format.json { render json: @monthly_consumptions, only: [:id, :year, :month, :consumption, :balance, :overhead, :customer_id], status: :ok }
    end
  end

  # GET /locations/:location_id/customers/:customer_id/monthly_consumptions/:id
  def show
    respond_to do |format|
      format.html
      format.json { render json: @monthly_consumption, only: [:id, :year, :month, :consumption, :balance, :overhead, :customer_id], status: :ok }
    end
  end

  # GET /locations/:location_id/customers/:customer_id/monthly_consumptions/new
  def new
    @monthly_consumption = @customer.monthly_consumptions.build
  end

  # POST /locations/:location_id/customers/:customer_id/monthly_consumptions
  def create
    @monthly_consumption = @customer.monthly_consumptions.build(monthly_consumption_params)

    if @monthly_consumption.save
      render json: { message: 'Consumption added successfully!', data: @monthly_consumption }, status: :created
    else
      render json: { errors: @monthly_consumption.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # GET /locations/:location_id/customers/:customer_id/monthly_consumptions/:id/edit
  def edit
  end

  # PATCH/PUT /locations/:location_id/customers/:customer_id/monthly_consumptions/:id
  def update
    if @monthly_consumption.update(monthly_consumption_params)
      render json: { message: 'Consumption updated successfully!', data: @monthly_consumption }, status: :ok
    else
      render json: { errors: @monthly_consumption.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /locations/:location_id/customers/:customer_id/monthly_consumptions/:id
  def destroy
    @monthly_consumption.destroy
    render json: { message: 'Consumption deleted successfully.' }, status: :ok
  end

  private

  # Find the associated customer
  def set_customer
    @customer = Customer.find(params[:customer_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Customer not found' }, status: :not_found
  end

  # Find the specific monthly consumption record
  def set_monthly_consumption
    @monthly_consumption = MonthlyConsumption.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Consumption record not found' }, status: :not_found
  end

  # Permit only safe parameters
  def monthly_consumption_params
    params.require(:monthly_consumption).permit(:month, :year, :consumption, :balance, :overhead)
  end
end

