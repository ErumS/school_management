Rails.application.routes.draw do
  resources :schools
  resources :classrooms
  resources :students
  resources :subjects
  resources :teachers
end