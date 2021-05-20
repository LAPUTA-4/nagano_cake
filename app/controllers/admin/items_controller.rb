class Admin::ItemsController < ApplicationController
  protect_from_forgery #createアクションのsaveメソッドがRailsのCSRF対策のために通らなくなる。 追記するとなぜか通る？

  def index
    @items = Item.page(params[:page]).per(10)
  end

  def new
    @item = Item.new
    @genres = Genre.all
  end

  def create
    if Item.create(item_params)
      flash[:notice] = "success"
      redirect_to admin_items_path
    else
      flash[:notice] = "エラーが発生しました"
      redirect_to new_admin_item_path
    end
  end

  def show
  end

  def edit
    @item = Item.find(params[:id])
    @genres = Genre.all
  end

  def update
    @item = Item.find(params[:id])

    @item.update(item_params)
    redirect_to admin_item_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :genre_id, :price, :is_active, :image)
  end

end
