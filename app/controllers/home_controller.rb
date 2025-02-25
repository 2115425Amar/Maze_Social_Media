class HomeController < ApplicationController
  def index
    @title_text = "Maze"
    @posts = Post.includes(:user, :comments, :likes).order(created_at: :desc)
  end

  def main
    render layout: false
  end
end


# Fetches all posts from the posts table.
# Uses .includes(:user, :comments, :likes) to eager load related data:
# :user → Loads the user who created the post.
# :comments → Loads comments on the post.
# :likes → Loads likes on the post.
# .order(created_at: :desc) → Orders posts from newest to oldest.