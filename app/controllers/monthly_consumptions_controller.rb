class MonthlyConsumptionsController < ApplicationController
  before_action :set_customer, only: %i[index new create]
  before_action :set_monthly_consumption, only: %i[show edit update destroy]
  respond_to :html, :json

  # GET /customers/:customer_id/monthly_consumptions
  def index
    @monthly_consumptions = @customer.monthly_consumptions
    respond_to do |format|
      format.html
      format.json { render json: @monthly_consumptions }
    end
  end

  # GET /monthly_consumptions/:id
  def show
    respond_to do |format|
      format.html
      format.json { render json: @monthly_consumption }
    end
  end

  # GET /customers/:customer_id/monthly_consumptions/new
  def new
    @monthly_consumption = @customer.monthly_consumptions.build
  end

  # POST /customers/:customer_id/monthly_consumptions
  def create
    @monthly_consumption = @customer.monthly_consumptions.build(monthly_consumption_params)

    if @monthly_consumption.save
      respond_to do |format|
        format.html { redirect_to customer_monthly_consumptions_path(@customer), notice: 'Consumption added successfully.' }
        format.json { render json: { message: 'Consumption added successfully!', data: @monthly_consumption }, status: :created }
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: { errors: @monthly_consumption.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  # GET /monthly_consumptions/:id/edit
  def edit
  end

  # PATCH/PUT /monthly_consumptions/:id
  def update
    if @monthly_consumption.update(monthly_consumption_params)
      respond_to do |format|
        format.html { redirect_to customer_monthly_consumptions_path(@monthly_consumption.customer), notice: 'Consumption updated successfully.' }
        format.json { render json: { message: 'Consumption updated successfully!', data: @monthly_consumption }, status: :ok }
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: { errors: @monthly_consumption.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /monthly_consumptions/:id
  def destroy
    @monthly_consumption.destroy
    respond_to do |format|
      format.html { redirect_to customer_monthly_consumptions_path(@monthly_consumption.customer), notice: 'Consumption deleted successfully.' }
      format.json { render json: { message: 'Consumption deleted successfully.' }, status: :ok }
    end
  end

  private

  # Find the associated customer
  def set_customer
    @customer = Customer.find(params[:customer_id])
  end

  # Find the specific monthly consumption record
  def set_monthly_consumption
    @monthly_consumption = MonthlyConsumption.find(params[:id])
  end

  # Permit only safe parameters
  def monthly_consumption_params
    params.require(:monthly_consumption).permit(:month, :year, :consumption)
  end
end
