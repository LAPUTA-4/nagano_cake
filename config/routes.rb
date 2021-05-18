Rails.application.routes.draw do
#only等は未着手resourcesで大体のアクションができるか確認
#deviseの設定
devise_for :admins, path: 'admin', controllers: {
    sessions: 'admin/sessions'
  }
devise_for :customers, path:'customers', controllers: {
    sessions: 'public/sessions',
    registrations: 'public/registrations'
}
    #パブリック側(scopemoduleでパブリックフォルダを参照しつつURLは変えない)
scope module: :public do
    #ホーム
    root :to => "homes#top"
    get "/about" =>"homes#about"

    #商品
    resources :items, only: [:index, :show]

    #会員
    resources :customers, only: [:edit, :update] do
       collection do
           get '/my_page' => 'customers#show'
           get 'unsubscribe'
           get 'withdraw'
       end
    end
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
