class CommentsController < ApplicationController
  def create
    # Rails.logger.debug "Received params: #{params.inspect}"  # Log all received parameters

    post = Post.find(params[:post_id])
    comment = post.comments.new(comment_params)

    if comment.save
      redirect_to post_path(post), notice: "Comment added!"
    else
      flash[:alert] = "Comment could not be created"
      redirect_to root_path
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :user_id)
  end
end
