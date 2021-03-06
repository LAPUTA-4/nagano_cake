Rails.application.routes.draw do
#deviseの設定
devise_for :admins, skip: :all
devise_scope :admin do
    get '/admin/sign_in' => 'admin/sessions#new', as: :new_admin_session
    post '/admin/sign_in' => 'admin/sessions#create', as: :admin_session
    delete '/admin/sign_out' => 'admin/sessions#destroy', as: :destroy_admin_session
end
devise_for :customers, skip: :all
devise_scope :customer do
    get '/customers/sign_in' => 'public/sessions#new', as: :new_customer_session
    post '/customers/sign_in' => 'public/sessions#create', as: :customer_session
    delete '/customers/sign_out' => 'public/sessions#destroy', as: :destroy_customer_session
    get '/customers/sign_up' => 'public/registrations#new', as: :new_customer_registration
    post '/customers'=> 'public/registrations#create'
end
    #パブリック側(scopemoduleでパブリックフォルダを参照しつつURLは変えない)
scope module: :public do
    #ホーム
    root :to => "homes#top"
    get "/about" =>"homes#about"

    #商品
    resources :items, only: [:index, :show]

    #会員
    get '/customers/my_page' => 'customers#show', as: :my_page_customers
    get '/customers/edit' => 'customers#edit', as: :customers_edit
    patch '/customers' => 'customers#update', as: :customers_update
    get '/customers/unsubscribe' => 'customers#unsubscribe'
    patch '/customers/withdraw' => 'customers#withdraw'

    #カート
    resources :cart_items, only: [:index, :update, :destroy, :create] do
        collection do
            delete 'destroy_all'
        end
    end

    #注文
    resources :orders, only: [:new, :create, :index, :show] do
        collection do
            post 'confirm'
            get 'complete'
        end
    end

    #配送先
    resources :addresses, except: [:new, :show]
end

#アドミン側(namespceで/admin/がつくようになる)
namespace :admin do
    root :to => "homes#top"
    resources :items, except: [:destroy]
    resources :genres, only: [:index, :edit, :create, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end