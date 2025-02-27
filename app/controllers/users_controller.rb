class UsersController < ApplicationController
  
    # POST /signup
    def create
      user = User.new(user_params)
      if user.save
        # user.save --> Runs validations (e.g., unique email, password presence, etc.).
        session[:user_id] = user.id                # Store user ID in session after signup
        render json: { id: user.id, name: user.name, email: user.email }, status: :created
      else
        render json: { error: user.errors.full_messages }, status: :unprocessable_entity   #http 422 error
      end
    end
    def signup
      render "users/registration/signup"
    end

    def login
      render "users/registration/login"
    end
  
    private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

  end
  