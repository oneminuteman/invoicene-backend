
class CustomersController < ApplicationController
  before_action :set_customer, only: %i[show edit update destroy]
  before_action :set_location, only: %i[index create]

  # GET /locations/:location_id/customers
  def index
    if @location
      # Include monthly_consumptions for each customer
      @customers = @location.customers.includes(:monthly_consumptions)
      render json: @customers.as_json(include: :monthly_consumptions), status: :ok
    else
      render json: { error: 'Location not found' }, status: :not_found
    end
  end

  # GET /customers/:id
  def show
    render json: @customer, status: :ok
  end

  # GET /customers/:id/edit
  def edit
    render json: @customer, status: :ok
  end

  # POST /locations/:location_id/customers
  def create
    @customer = @location.customers.build(customer_params_for_creation) if @location

    if @customer&.save
      render json: { message: 'Customer created successfully!', data: @customer }, status: :created
    else
      errors = @customer ? @customer.errors.full_messages : ['Location not found to create customer under']
      render json: { errors: errors }, status: :unprocessable_entity
    end
  end

  # PUT/PATCH /customers/:id
  def update
    if @customer.update(customer_params_for_update)
      @customer.monthly_consumptions.each do |mc|
        mc.balance = mc.balance.to_f
        mc.overhead = mc.overhead.to_f

        if mc.balance > 0
          mc.overhead = 0
        elsif mc.overhead > 0
          mc.balance = 0
        end

        mc.save!
      end

      render json: { message: "Customer and monthly consumptions updated!", data: @customer.as_json(include: :monthly_consumptions) }, status: :ok
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
    return render json: { error: 'Customer not found' }, status: :not_found unless @customer
  end

  # Find the location by ID for nested resources
  def set_location
    @location = Location.find_by(id: params[:location_id]) if params[:location_id]
    return render json: { error: 'Location not found' }, status: :not_found unless @location
  end

  # Permitted parameters for customer creation
  def customer_params_for_creation
    params.require(:customer).permit(:name)
  end

  # Permitted parameters for customer update
  def customer_params_for_update
    params.require(:customer).permit(
      :name,
      monthly_consumptions_attributes: [:id, :month, :year, :consumption, :balance, :overhead, :_destroy]
    )
  end
end

