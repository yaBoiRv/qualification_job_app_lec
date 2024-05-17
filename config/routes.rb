# frozen_string_literal: true

Rails.application.routes.draw do

  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all

  get 'calendar_group_reservations/index'
  resources :calendar_groups do
    resources :reservations, only: [:index], controller: 'calendar_group_reservations'
    resources :participant_reservations
    delete 'remove_user/:user_id', to: 'calendar_groups#remove_user', as: 'remove_user'
    resources :calendar_groups
  end
  resources :calendar_horses
  resources :calendar_ponies
  resources :users, only: %i[new create]
  resources :exercises
  resources :events
  resources :course_positions
  resources :users
  patch 'update_password', to: 'users#update_password'
  resources :pending_associations, only: [] do
    member do
      post 'accept'
      delete 'reject'
    end
  end
  # match '*path', to: 'errors#not_found', via: :all
  post '/support', to: 'contact#support'
  get '/calendar_groups/:calendar_group_id/participant_reservations/new_form', to: 'participant_reservations#new_form',
                                                                               as: 'new_reservation_form'
  get '/search', to: 'users#search'
  get 'login', to: 'users#login'
  post 'login', to: 'users#authenticate'
  get 'logout', to: 'users#logout', as: :logout
  get 'profile', to: 'users#profile', as: :profile
  get 'saved_positions', to: 'users#saved_positions', as: :saved_positions
  get 'contact/index'
  get 'about/index'
  get 'calendar_groups/index'
  get '/show_positions', to: 'course_positions#show_positions'

  post 'save_horse_exercise/:id', to: 'course_positions#save_horse_exercise', as: 'save_horse_exercise'
  post 'save_horse_course/:id', to: 'course_positions#save_horse_course', as: 'save_horse_course'
  post 'save_pony_course/:id', to: 'course_positions#save_pony_course', as: 'save_pony_course'
  post 'save_pony_exercise/:id', to: 'course_positions#save_pony_exercise', as: 'save_pony_exercise'

  get 'unsave_horse_exercise/:id', to: 'course_positions#unsave_horse_exercise', as: 'unsave_horse_exercise'
  get 'unsave_horse_course/:id', to: 'course_positions#unsave_horse_course', as: 'unsave_horse_course'
  get 'unsave_pony_course/:id', to: 'course_positions#unsave_pony_course', as: 'unsave_pony_course'
  get 'unsave_pony_exercise/:id', to: 'course_positions#unsave_pony_exercise', as: 'unsave_pony_exercise'

  get 'mark_used_horse_exercise/:id', to: 'course_positions#mark_used_horse_exercise', as: 'mark_used_horse_exercise'
  get 'mark_unused_horse_exercise/:id', to: 'course_positions#mark_unused_horse_exercise',
                                        as: 'mark_unused_horse_exercise'

  get 'mark_used_horse_course/:id', to: 'course_positions#mark_used_horse_course', as: 'mark_used_horse_course'
  get 'mark_unused_horse_course/:id', to: 'course_positions#mark_unused_horse_course', as: 'mark_unused_horse_course'

  get 'mark_used_pony_exercise/:id', to: 'course_positions#mark_used_pony_exercise', as: 'mark_used_pony_exercise'
  get 'mark_unused_pony_exercise/:id', to: 'course_positions#mark_unused_pony_exercise', as: 'mark_unused_pony_exercise'

  get 'mark_used_pony_course/:id', to: 'course_positions#mark_used_pony_course', as: 'mark_used_pony_course'
  get 'mark_unused_pony_course/:id', to: 'course_positions#mark_unused_pony_course', as: 'mark_unused_pony_course'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show"
  root 'welcome#index', as: 'welcome_page', via: :all
  # Defines the root path route ("/")
  # root "posts#index"
end
