class Public::CartItemsController < ApplicationController
  def index
     @customer = Customer.find_by(id: current_customer.id)
     @cart_items = @customer.cart_items.all
     @cart_items.each do |n|
      count = n.item.price * n.amount * 1.1
      @sum = count + @sum.to_i
     end
     #カートを空にしたとき、@sumにはnilが入っているのでViewファイルでfloorメソッドが働かずにエラーになるので、
     #@sumに0を代入してあげる
     @sum = 0 if @sum == nil
  end

  def update
      item = CartItem.find(params[:id])
    if item.update(cart_item_params)
      redirect_to request.referer
    else
      redirect_to root_path
    end
  end

  def destroy
    item = CartItem.find(params[:id])
    if item.destroy
      redirect_to request.referer
    else
      redirect_to root_path
    end
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
