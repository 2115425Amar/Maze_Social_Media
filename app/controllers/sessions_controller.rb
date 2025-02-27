class SessionsController < ApplicationController
    # POST /login
    # Handles user login authentication
    def create
      # Find user by email from login form
      user = User.find_by(email: params[:session][:email])
      
      # Check if user exists and password is correct using authenticate method
      if user&.authenticate(params[:session][:password])
        # Store user id in session to keep them logged in
        session[:user_id] = user.id
        # Redirect to posts page with success message
        redirect_to posts_path, notice: 'Logged in successfully!'
      else
        # Show error message if login fails
        flash.now[:alert] = 'Invalid email or password'
        # Re-render login form with error status
        render :new, status: :unprocessable_entity
      end
    end
  
    # DELETE /logout
    # Handles user logout
    def destroy
      # Clear user id from session
      session[:user_id] = nil
      # Return success message as JSON
      render json: { message: "Logged out successfully" }, status: :ok
    end
  end
  