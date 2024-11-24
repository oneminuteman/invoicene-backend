class CustomersController < ApplicationController
  def index
    @location = Location.find(params[:location_id])
    @customers = @location.customers
  end

  def show
    @customer = Customer.find(params[:id])
    @monthly_consumptions = @customer.monthly_consumptions
  end

  def new
    @location = Location.find(params[:location_id])
    @customer = @location.customers.build
  end

  def create
    @location = Location.find(params[:location_id])
    @customer = @location.customers.build(customer_params)

    if @customer.save
      redirect_to location_customers_path(@location), notice: 'Customer added successfully.'
    else
      render :new
    end
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to @customer, notice: 'Customer updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy
    redirect_to location_customers_path(@customer.location), notice: 'Customer deleted successfully.'
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :email, :phone)
  end
end
