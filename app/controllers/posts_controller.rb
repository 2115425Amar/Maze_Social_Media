class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :destroy]
  before_action :ensure_user_owns_post, only: [:edit, :update, :destroy]  

  def edit
    # @post is already set by before_action
  end

  def update
    if @post.update(post_params)
      redirect_to posts_path, notice: "Post was successfully updated."
    else
      # Return validation errors
      flash.now[:alert] = @post.errors.full_messages.join(", ")
      render :edit, status: :unprocessable_entity
    end
  end

  def index
    @posts = Post.includes(:user, :comments, :likes)
                 .public_posts
                 .recent
    respond_to do |format|
      format.html
      format.json { render json: @posts, include: [:user, :comments, :likes] }
    end
    # posts = Post.includes(:user, :comments, :likes).order(created_at: :desc)
    # render json: posts, include: [:user, :comments, :likes]
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user&.id
    @post.public = params[:post][:public] == "true"
    
    if @post.save
      redirect_to posts_path, notice: "Post was successfully created."
    else
      flash.now[:alert] = @post.errors.full_messages.join(", ")
      redirect_to posts_path, status: :unprocessable_entity
    end
  end

  def destroy
    if @post.destroy
      redirect_to posts_path, notice: "Post was successfully deleted."
    else
      redirect_to posts_path, alert: "Failed to delete post."
    end
  end
  
  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content)
  end

  def ensure_user_owns_post
    unless @post.user_id == current_user&.id
      redirect_to posts_path, alert: "You are not authorized to perform this action."
    end
  end
end



# const { Post, User, Comment, Like } = require('./models'); // Sequelize models

# // GET /posts
# app.get('/posts', async (req, res) => {
#   try {
#     const posts = await Post.findAll({
#       include: [
#         { model: User },
#         { model: Comment },
#         { model: Like }
#       ],
#       order: [['created_at', 'DESC']]
#     });
#     res.json(posts);
#   } catch (error) {
#     console.error(error);
#     res.status(500).json({ error: "An error occurred while fetching posts" });
#   }
# });

# // POST /posts
# app.post('/posts', async (req, res) => {
#   try {
#     const { content, user_id } = req.body;
#     const post = await Post.create({ content, user_id });

#     // Return created post
#     res.status(201).json(post);
#   } catch (error) {
#     console.error(error);
#     res.status(422).json({ error: "Post could not be created" });
#   }
# });

