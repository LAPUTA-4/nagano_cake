[アプリケーション詳細設計_回答](https://drive.google.com/file/d/1fyU5TwHY5kfi-MDcpx9NjS00oEirnNpk/view)
# gemインストール
```
gem 'refile'
gem 'devise'
gem 'pry-rails'
gem 'pry-byebug'
gem 'kaminari', '~> 0.17.0'
gem 'jp_prefecture'
gem 'bootstrap', '~> 4.5'
gem 'jquery-rails'
gem 'font-awesome-sass', '~> 5.13'
gem 'rubocop'
gem 'enum_help'
group :development do
    gem 'rubocop', require: false
    gem 'rubocop-performance', require: false
    gem 'rubocop-rails', require: false
    gem 'rubocop-rspec'
end
```
# モデル作成
<details>
<summary>モデル作成をクリックで展開</summary>

### 管理者
``` 
$ rails g devise Admin 
```
### 会員
```
$ rails g devise Customer
#デフォルトはメールアドレスとパスワードのみ
```
> カラム追加
```
$ rails g migration AddColumnsToCustomers 
```
>XXXXXXXXXXX_add_columns_to_customers.rb
``` ruby
  def change
    add_column :customers, :last_name, :string
    add_column :customers, :first_name, :string
    add_column :customers, :last_name_kana, :string
    add_column :customers, :first_name_kana, :string
    add_column :customers, :postal_code, :string
    add_column :customers, :address, :string
    add_column :customers, :telephone_number, :string
    add_column :customers, :is_deleted, :boolean, default: false
  end
```
### 配送先
```
$ rails g model Address customer_id:integer postal_code:string address:string name:string
```
### カート
```
$ rails g model CartItem customer_id:integer item_id:integer amount:integer
```
### 商品
```
$ rails g model Item genre_id:integer name:string introduction:text image_id:string price:integer is_active:boolean
```
### ジャンル
```
$ rails g model Genre name:string
```
### 注文
```
$ rails g model Order customer_id:integer postal_code:string address:string name:string shipping_cost:integer total_payment:integer payment_method:integer status:integer
```
### 注文商品
```
$ rails g model OrderDetail item_id:integer order_id:integer price:integer amount:integer making_status:integer
```

rails db:migrate
</details>



# アソシエーション作成

<details>
<summary>モデル作成をクリックで展開</summary>


>Customer.rb
~~~customer.rb
has_many :addresses, dependent: :destroy
has_many :cart_items, dependent: :destroy
has_many :orders, dependent: :destroy
~~~


>Address.rb
~~~address.rb
belong_to :customer
~~~

>CartItem.rb
~~~cart_item.rb
belong_to :customer
belong_to :item
~~~

>Order.rb
~~~order.rb

belongs_to :customer
has_many :order_details, dependent: :destroy
accepts_nested_attributes_for :order_details
~~~

>OrderDetail.rb
~~~order_detail.rb
belongs_to :order
belongs_to :item
~~~

>Item.rb
~~~item.rb

belong_to :genre
has_many :cart_items, dependent: :destroy
has_many :order_details, dependent: :destroy

~~~


>Genre.rb
~~~genre.rb

has_many :Items

~~~

</details>

# コントローラー作成
[namespaceを使うときのコントローラー使用方法について](https://qiita.com/annaaida/items/7548e4ea3522e8a6f5b7)
[deviseで作成したコントローラー,ルーティングのカスタマイズ1](https://qiita.com/YUSUKE39/items/d8aedc0c3a3017b36691)
[deviseで作成したコントローラー,ルーティングのカスタマイズ2](https://qiita.com/hakatatech/items/f991d54ff527edb844d9)
## パブリックサイド
### ホーム
```
rails g controller public/homes top about
```
### 商品
```
rails g controller public/items index show
```

### 登録・ログイン機能
```
rails g devise:controllers public
```
※登録とログイン機能しか使わないので、publicフォルダ内が汚くなるので下記以外捨てて問題ないと思います。もし問題が起きた場合は上記を再実行すれば全部上書きされるので90%の確立で治ると思います。
```
public/registrations_controller.rb
public/sessions_controller.rb
```
>public/registrations_controller.rb
``` ruby
    def new
    end
    def create
    end
```
>public/sessions_controller.rb
``` ruby
    def new
    end
    def create
    end
    def destroy
    end
```
### 会員
```
rails g controller public/customers show edit update unsubscribe withdraw
```

### カート
```
rails g controller public/cart_items index update destroy destroy_all create
```
### 注文
```
rails g controller public/orders new confirm complete create index show
```
### 配送先
```
rails g controller public/addresses index edit create update destroy
```


## アドミンサイド
### ログイン機能
```
rails g devise:controllers admin
```
※ログイン機能しか使わないので、publicフォルダ内が汚くなるので下記以外捨てて問題なくその他のアクションに関してはdevise側でsuperが自動的に発動すると思います。もし問題が起きた場合は上記を再実行すれば全部上書きされるので90%の確立で治ると思います。
```
public/sessions_controller.rb
```
>admin/sessions_controller.rb
``` ruby
    def new
        super
    end
    def create
        super
    end
    def destroy
        super
    end
```
### ホーム
```
rails g controller admin/homes top
```

### 商品
```
rails g controller admin/items index new create show edit update
```

### ジャンル
```
rails g controller admin/genres index create edit update
```

### 会員
```
rails g controller admin/customers index show edit update
```

### 注文
```
rails g controller admin/orders show update
```

### 注文商品
```
rails g controller admin/orders_details update
```

# ルーティング作成

<details>
<summary>ルーティング作成をクリックで展開</summary>

[見やすくするためなるべくresourcesで書こう！なんて難しいことが解説に書かれてるけどどうすればいいの？？？それがCollectionかmemberだ！](https://qiita.com/imayasu/items/19f43a5726ed2170f611#collection%E3%81%A8member)
[管理者側と顧客・ゲスト側でURLが変わるのなんなん？？？それがnamespaceだ](https://qiita.com/ryosuketter/items/9240d8c2561b5989f049#namespace)
[devise_forってなんだ？？？](http://www.code-magagine.com/?p=13096)
>routes.rb

~~~ ruby
#only等は未着手resourcesで大体のアクションができるか確認
#deviseの設定
devise_for :admins, path: 'admin', controllers: {
    sessions: 'admin/sessions'
  }
devise_for :customers, path:'customers', controllers: {
    sessions: 'public/registrations',
    registrations: 'public/registrations'
}
    #パブリック側(scopemoduleでパブリックフォルダを参照しつつURLは変えない)
scope module: :public do
    #ホーム
    root :to => "homes#top"
    get "/about" =>"homes#about"

    #商品
    resources :items, only[:index, :show]

    #会員
    resources :customers, only[:show, :edit, :update] do
       collection do
           get 'unsubscribe'
           get 'withdraw'
       end
    end
    #カート
    resources :cart_items, only[:index, :update, :destroy, :create] do
        collection do
            delete 'destroy_all'
        end
    end

    #注文
    resources :orders, only[:new, :create, :index, :show] do
        collection do
            post 'confirm'
            get 'complete'
        end
    end

    #配送先
    resources :addresses, except[:new, :show]
end

#アドミン側(namespceで/admin/がつくようになる)
namespace :admin do
    root :to => "homes#top"
    resources :items, except[:destroy]
    resources :genres, only[:index, :edit, :create, :update]
    resources :customers, only[:index, :show, :edit, :update]
    resources :orders, only[:show, :update]
    resources :order_details, only[:update]
end


~~~

</details>