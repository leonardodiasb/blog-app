# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    post "/:api/login", to: "sessions#login", as: "api_login"
  end
  get "/users/:user_id/posts", to: "posts#index", as: "user_posts"
  post "/users/:user_id/posts", to: "posts#create", as: "user_create_post"
  get "/users/:user_id/posts/new", to: "posts#new", as: "user_new_post"
  get "/users/:user_id/posts/:id", to: "posts#show", as: "user_post"
  delete "/users/:user_id/posts/:id", to: "posts#destroy", as: "user_destroy_post"
  post "/users/:user_id/posts/:post_id/comments", to: "comments#create", as: "user_create_post_comment"
  get "/users/:user_id/posts/:post_id/comments/new", to: "comments#new", as: "user_new_post_comment"
  delete "/users/:user_id/posts/:post_id/comments/:id", to: "comments#destroy", as: "user_destroy_comment"
  post "/users/:user_id/posts/:id/likes", to: "likes#create", as: "user_create_post_like"
  get "/users", to: "users#index", as: "users"
  get "/users/:id", to: "users#show", as: "user"
  get "/:api/users/:user_id/posts/", to: "posts#index", as: "api_list_posts"
  get "/:api/users/:user_id/posts/:id/", to: "posts#show", as: "api_list_comments"
  post "/:api/users/:user_id/posts/:id/comments", to: "comments#create", as: "api_create_comment"
  post "/:api/register", to: "users#create", as: "api_register"
  root to: "users#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
