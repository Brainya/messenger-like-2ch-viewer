Rails.application.routes.draw do
  get 'subbacks/:subback_id' => 'subbacks#index'
  get 'threads/:subback_id/:thread_id' => 'threads#index'
end
