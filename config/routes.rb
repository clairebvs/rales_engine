Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do

      namespace :merchants do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/:id/favorite_customer', to: 'favorite_customer#show'
        get '/revenue', to: 'revenue_merchants_date#show'
        get '/:id/revenue', to: 'revenue#show'
        get '/:id/items', to: 'items#show'
        get '/:id/invoices', to: 'invoices#show'
        get '/random', to: 'random#show'
        get '/most_revenue', to: 'top_merchants#show'
        get '/most_items', to: 'most_items#show'
        get '/:id/customers_with_pending_invoices', to: 'customers_unpaid#show'
      end

      namespace :items do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
        get '/:id/merchant', to: 'merchant#show'
        get '/:id/invoice_items', to: 'invoice_items#show'
        get '/most_items', to: 'most_items#show'
        get '/most_revenue', to: 'top_items#show'
        get '/:id/best_day', to: 'best_day#show'
      end

      namespace :invoices do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get "/:id/revenue", to: 'revenue#show'
        get "/random", to: 'random#show'
        get '/:id/transactions', to: 'transactions#show'
        get '/:id/invoice_items', to: 'invoice_items#show'
        get '/:id/items', to: 'items#show'
        get '/:id/customer', to: 'customer#show'
        get '/:id/merchant', to: 'merchant#show'
      end

      namespace :transactions do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
        get '/:id/invoice', to: 'invoice#show'
      end

      namespace :invoice_items do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
        get '/:id/invoice', to: 'invoice#show'
        get '/:id/item', to: 'item#show'
      end

      namespace :customers do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
        get '/:id/invoices', to: 'invoices#show'
        get '/:id/transactions', to: 'transactions#show'
        get '/:id/favorite_merchant', to: 'favorite_merchant#show'
      end

      resources :customers, only: [:index, :show]
      resources :merchants, only: [:index, :show]
      resources :invoices, only: [:index, :show]
      resources :transactions, only: [:index, :show]
      resources :items, only: [:index, :show]
      resources :invoice_items, only: [:index, :show]

    end
  end
end
