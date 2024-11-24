class MonthlyConsumptionsController < ApplicationController
  def index
    @customer = Customer.find(params[:customer_id])
    @monthly_consumptions = @customer.monthly_consumptions
  end

  def show
    @monthly_consumption = MonthlyConsumption.find(params[:id])
  end

  def new
    @customer = Customer.find(params[:customer_id])
    @monthly_consumption = @customer.monthly_consumptions.build
  end

  def create
    @customer = Customer.find(params[:customer_id])
    @monthly_consumption = @customer.monthly_consumptions.build(monthly_consumption_params)

    if @monthly_consumption.save
      redirect_to customer_monthly_consumptions_path(@customer), notice: 'Consumption added successfully.'
    else
      render :new
    end
  end

  def edit
    @monthly_consumption = MonthlyConsumption.find(params[:id])
  end

  def update
    @monthly_consumption = MonthlyConsumption.find(params[:id])
    if @monthly_consumption.update(monthly_consumption_params)
      redirect_to customer_monthly_consumptions_path(@monthly_consumption.customer), notice: 'Consumption updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @monthly_consumption = MonthlyConsumption.find(params[:id])
    @monthly_consumption.destroy
    redirect_to customer_monthly_consumptions_path(@monthly_consumption.customer), notice: 'Consumption deleted successfully.'
  end

  private

  def monthly_consumption_params
    params.require(:monthly_consumption).permit(:month, :year, :consumption)
  end
end
