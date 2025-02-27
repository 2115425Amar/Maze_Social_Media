class LikesController < ApplicationController
    # POST /posts/:post_id/likes
    def create
      post = Post.find(params[:post_id])  # Find the post using post_id
      like = post.likes.new(user_id: params[:user_id])    # Associate the like with the user
  
      if like.save
        redirect_to posts_path notice: "Like is created."
        # render json: like, status: :created
      else
        render json: { error: "Like could not be created" }, status: :unprocessable_entity
      end
    end
  
    # DELETE /posts/:post_id/likes/:user_id
    def destroy
      post = Post.find(params[:post_id])
      like = post.likes.find_by(user_id: params[:user_id])  # Find the like by user_id
  
      if like
        like.destroy  # Remove the like
        redirect_to posts_path notice: "Like is removed."
        # render json: { message: "Disliked the post" }, status: :ok
      else
        render json: { error: "Like not found" }, status: :not_found
      end
    end
    
  end
  