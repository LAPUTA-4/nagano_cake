class Public::CartItemsController < ApplicationController
  def index
     @customer = Customer.find_by(id: current_customer.id)
     @cart_items = @customer.cart_items.all
     @cart_items.each do |n|
      count = n.item.price * n.amount
      @sum = count + @sum.to_i
     end
  end

  def update
  end

  def destroy
  end

  def destroy_all
    cart_items = CartItem.where(customer_id: current_customer.id)
    cart_items.each do |cart_item|
      cart_item.destroy
    end
    redirect_to request.referer
  end

  def create
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
