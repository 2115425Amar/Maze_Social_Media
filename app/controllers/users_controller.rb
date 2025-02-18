class UsersController < ApplicationController
    # POST /signup
    def create
      user = User.new(user_params)
      if user.save
        render json: { id: user.id, name: user.name, email: user.email }, status: :created
      else
        render json: { error: user.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  end
  