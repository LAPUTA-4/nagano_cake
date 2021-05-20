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
  end
  
  private
  
  def item_params
    params.require(:item).permit(:item_id, :amount) 
  end
  
end
