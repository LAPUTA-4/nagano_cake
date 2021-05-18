class Admin::ItemsController < ApplicationController
  protect_from_forgery #createアクションのsaveメソッドがRailsのCSRF対策のために通らなくなる。 追記するとなぜか通る？
  
  def index
  end

  def new
    @item = Item.new
    @genres = Genre.all
  end

  def create
    if Item.create(item_params)
      redirect_to root_path
    else
      redirect_to admin_items_path
    end
  end
  
  def show
  end

  def edit
  end

  def update
  end
  
  private
  
  def item_params
    params.require(:item).permit(:name, :introduction, :genre_id, :price, :is_active, :image)
  end
  
end
