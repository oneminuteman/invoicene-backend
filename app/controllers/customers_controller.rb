class CustomersController < ApplicationController
  before_action :set_customer, only: %i[show edit update destroy]
  before_action :set_location, only: %i[create]

  # GET /customers
  # GET /customers.json
  def index
    @customers = Customer.all
    respond_to do |format|
      format.html # Renders default HTML view
      format.json { render json: @customers }
    end
  end

  # GET /customers/:id
  # GET /customers/:id.json
  def show
    respond_to do |format|
      format.html # Renders default HTML view
      format.json { render json: @customer }
    end
  end

  # POST /locations/:location_id/customers
  def create
    if @location
      @customer = @location.customers.build(customer_params)
    else
      @customer = Customer.new(customer_params)
    end

    if @customer.save
      respond_to do |format|
        format.html { redirect_to @customer, notice: 'Customer was successfully created.' }
        format.json { render json: { message: 'Customer created successfully!', data: @customer }, status: :created }
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: { errors: @customer.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  # PUT/PATCH /customers/:id
  # PUT/PATCH /customers/:id.json
  def update
    if @customer.update(customer_params)
      respond_to do |format|
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
        format.json { render json: { message: 'Customer updated successfully!', data: @customer }, status: :ok }
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: { errors: @customer.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/:id
  # DELETE /customers/:id.json
  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'Customer was successfully deleted.' }
      format.json { render json: { message: 'Customer deleted successfully.' }, status: :ok }
    end
  end

  private

  # Find the customer by ID
  def set_customer
    @customer = Customer.find_by(id: params[:id])
    unless @customer
      render json: { error: 'Customer not found' }, status: :not_found
    end
  end

  # Find the location by ID for nested resources
  def set_location
    if params[:location_id]
      @location = Location.find_by(id: params[:location_id])
      unless @location
        render json: { error: 'Location not found' }, status: :not_found and return
      end
    end
  end

  # Permit only allowed parameters
  def customer_params
    params.require(:customer).permit(
      :name,
      :location_id,
      monthly_consumptions_attributes: %i[month year consumption]
    )
  end
end
