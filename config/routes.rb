# Rails.application.routes.draw do
#   resources :users, only: [:create]
#   resources :posts, only: [:index, :create]
#   resources :comments, only: [:create]
#   resources :likes, only: [:create]
# end

Rails.application.routes.draw do
   # Define the root path to point to home#index
  root 'home#main'

  get "/posts", to: "home#index"


 
  # User routes
  post "/signup", to: "users#create"

  # Session (Login & Logout)
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"


  # Post routes
  get "/posts", to: "posts#index"
  post "/posts", to: "posts#create"
  get "posts/:id/edit", to: "posts#edit"
  patch "/posts/:id", to: "posts#update", as: "post"  # Added update route
  delete "/posts/:id", to: "posts#destroy"  # Added delete route


  # Comment routes
  post "/posts/:post_id/comments", to: "comments#create", as: "post_comments"

  # Like routes
  post "/posts/:post_id/likes", to: "likes#create", as: "post_likes"

  #dislike post
  delete "/posts/:post_id/likes/:user_id", to: "likes#destroy", as: "post_dislike"

end


# How This API Works
# A user signs up → POST /users
# A user creates a post → POST /posts
# A user fetches all posts → GET /posts
# A user comments on a post → POST /comments
# A user likes a post/comment → POST /likes


# Summary
# The get 'home/index' route maps the URL /home/index to the index action of the HomeController.
# The root 'home#index' route sets the root URL of the application to the index action of the HomeController.
# This setup means that when users visit the base URL of your application,
#  they will be directed to the index action of the HomeController,
#  and they can also explicitly visit /home/index to reach the same action.
