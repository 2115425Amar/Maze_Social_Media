class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :destroy]

  def edit
    # @post is already set by before_action
  end

  def update
    if @post.update(post_params)
      render json: @post, status: :ok
    else
      render json: { error: "Post could not be updated", messages: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    posts = Post.includes(:user, :comments, :likes).order(created_at: :desc)
    render json: posts, include: [:user, :comments, :likes]
  end

  def create
    post = Post.new(post_params)
    post.user_id = current_user&.id
    if post.save
      render json: post, status: :created
    else
      render json: { error: "Post could not be created", messages: post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # def destroy
  #   if @post.destroy
  #     render json: { message: "Post deleted successfully" }, status: :ok
  #   else
  #     render json: { error: "Post could not be deleted" }, status: :unprocessable_entity
  #   end
  # end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
  
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Post was successfully deleted." }
      format.json { render json: { message: "Post deleted successfully" }, status: :ok }
    end
  end
  
  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :public)
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

