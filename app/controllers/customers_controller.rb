class CustomersController < ApplicationController
  before_action :set_customer, only: %i[show edit update destroy]
  before_action :set_location, only: %i[index create]

  # GET /locations/:location_id/customers
  def index
    if @location
      @customers = @location.customers.includes(:monthly_consumptions)
      render json: @customers.as_json(include: :monthly_consumptions), status: :ok
    else
      render json: { error: 'Location not found' }, status: :not_found
    end
  end

  # GET /customers/:id
  def show
    if @customer
      render json: @customer, status: :ok
    else
      render json: { error: 'Customer not found' }, status: :not_found
    end
  end

  # POST /locations/:location_id/customers
  def create
    @customer = @location.customers.build(customer_params) if @location

    if @customer&.save
      render json: { message: 'Customer created successfully!', data: @customer }, status: :created
    else
      render json: { errors: @customer.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT/PATCH /customers/:id
  # PUT/PATCH /customers/:id
def update
  if @customer.update(customer_params)
    @customer.monthly_consumptions.each do |mc|
      # Ensure balance and overhead rules
      mc.balance = mc.balance.to_f
      mc.overhead = mc.overhead.to_f

      if mc.balance > 0
        mc.overhead = 0
      elsif mc.overhead > 0
        mc.balance = 0
      end

      mc.save!  # Save the updates
    end

    render json: { message: "Customer and monthly consumptions updated!", data: @customer.monthly_consumptions }, status: :ok
  else
    render json: { errors: @customer.errors.full_messages }, status: :unprocessable_entity
  end
end


  # DELETE /customers/:id
  def destroy
    if @customer.destroy
      render json: { message: 'Customer deleted successfully.' }, status: :ok
    else
      render json: { error: 'Failed to delete customer.' }, status: :unprocessable_entity
    end
  end

  private

  # Find the customer by ID
  def set_customer
    @customer = Customer.find_by(id: params[:id])
    render json: { error: 'Customer not found' }, status: :not_found unless @customer
  end

  # Find the location by ID for nested resources
  def set_location
    @location = Location.find_by(id: params[:location_id]) if params[:location_id]
    render json: { error: 'Location not found' }, status: :not_found unless @location
  end

  # Permit only allowed parameters
  def customer_params
    params.require(:customer).permit(
      monthly_consumptions_attributes: [:id, :month, :year, :consumption, :balance, :overhead]
    )
  end
end


