Rails.application.routes.draw do
  get 'subbacks/:subback_id' => 'subbacks#index'
end
