class SessionsController < ApplicationController
    # POST /login
    def create
      user = User.find_by(email: params[:session][:email])
      if user&.authenticate(params[:session][:password])
        session[:user_id] = user.id
        redirect_to posts_path, notice: 'Logged in successfully!'
      else
        flash.now[:alert] = 'Invalid email or password'
        render :new, status: :unprocessable_entity
      end
    end
  
    # DELETE /logout
    def destroy
      session[:user_id] = nil  # Clear session
      render json: { message: "Logged out successfully" }, status: :ok
    end
  end
  