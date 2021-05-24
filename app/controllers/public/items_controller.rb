class Public::ItemsController < ApplicationController
  def index
    # urlにcategory_id(params)がある場合
    if params[:name]
      # ?name=プリンとしたら
      @genre = Genre.find_by(:name => params[:name])
       
      # category_idと紐づく投稿を取得
      @items = @genre.items.page(params[:page]).per(7)
      @items_count = @genre.items.all.count
    else
      # 投稿すべてを取得
      @items = Item.page(params[:page]).per(7)
    end
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end
end
