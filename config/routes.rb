Rails.application.routes.draw do
  root 'boards#index'

  get 'subbacks/:subback_server/:subback_id' => 'subbacks#index', constraints: { subback_server: /[^\/]+/ }
  get 'threads/:subback_server/:subback_id/:thread_id' => 'threads#index', constraints: { subback_server: /[^\/]+/ }
end
