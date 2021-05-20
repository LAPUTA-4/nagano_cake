class Public::CartItemsController < ApplicationController
  def index
    @cart_item = CartItem.where(customer_id: current_customer.id)
    @item = Item.where(id: @cart_item.item_id)
    binding.pry
    #@item = Item.find_by!(id:@cart_item.item_id)
  end

  def update
  end

  def destroy
  end

  def destroy_all
  end

  def create
    CartItem.create(item_params)
    if @cart_item = CartItem.create(cart_item_params)
      redirect_to cart_items_path
    else
      redirect_to request.referer
    end
  end
  
  private
  
  def cart_item_params
    params.require(:cart_item).permit(:customer_id, :item_id, :amount)
  end
end
