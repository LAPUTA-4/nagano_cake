class Public::ItemsController < ApplicationController
  def index
    # urlにcategory_id(params)がある場合
    if params[:name]
      # ?name=プリンとしたら
      @genre = Genre.find_by(:name => params[:name])
       
      # category_idと紐づく投稿を取得
      @items = @genre.items.all
    else
      # 投稿すべてを取得
      @items = Item.all
    end
  end

  def show
  end
end
