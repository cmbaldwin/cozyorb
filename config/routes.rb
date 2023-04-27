Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  resources :ohayos

  root 'ohayo#index'
  get :flickr_bg, controller: :ohayo

  resources :tweets do
    collection do
      post 'display/(.:format)', as: :display, to: 'tweets#display_change'
    end
  end
  get 'tweets/tweet_results/(.:format)' => 'tweets#tweet_results', as: :tweet_results
  post 'tweets/tweet_upload/(.:format)', as: :tweet_upload, to: 'tweets#tweet_upload'

  resources :likes do
    collection do
      post 'display/(.:format)', as: :display, to: 'likes#display_change'
    end
  end
  get 'likes/like_results/(.:format)' => 'likes#like_results', as: :like_results
  post 'likes/like_upload/(.:format)', as: :like_upload, to: 'likes#like_upload'

  get 'scrapbook' => 'scrapbook#index', as: 'scrapbook'
  post 'scrapbook' => 'scrapbook#search_results', as: 'scrapbook_search', defaults: { format: 'js' }

  resources :posts
  get 'about' => 'about#index', as: 'about'

  get '.well-known/nostr.json' => 'application#nostr', :defaults => { format: 'json' }
end
