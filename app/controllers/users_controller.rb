class UsersController < ApplicationController
    before_action :authorize, except: [:create]
    skip_before_action :authorize, only: [:index]
  
    def index 
      users = User.all 
      render json: users
    end 
  
    def show
      user = User.find_by(id: session[:user_id])
      if user
        render json: user
      else
        render json: { error: "Not authorized" }, status: :unauthorized
      end
    end
  
    def create
      user = User.new(user_params)
      if user.save
        render json: { message: 'User created successfully' }, status: :created
      else
        render json: { error: user.errors.full_messages, params: params }, status: :unprocessable_entity
      end
    end
    
  
    private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  end
  