class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  def new
    @order = Order.new
    @customer = current_customer
    @addresses = @customer.addresses
    @cartitems = @customer.cart_items
  end

  def confirm
    @order = Order.new(order_params)
    @customer = current_customer
    @addresses = @customer.addresses
    @cartitems = @customer.cart_items
    @order.shipping_cost = 800
    @order.status = 0
    if params[:order][:pay_method] == "A"
      @order.payment_method = 0
    else
      @order.payment_method = 1
    end
    if params[:order][:addresses] == "address_mine"
      @order.postal_code = @customer.postal_code
      @order.address = @customer.address
      @order.name = @customer.last_name + " " + @customer.first_name
    elsif params[:order][:addresses] == "address_list"
      list = Address.find(params[:order][:address_id])
      @order.postal_code = list.postal_code
      @order.address = list.address
      @order.name = list.name
    elsif params[:order][:addresses] == "address_new"
      @order.postal_code = params[:order][:postal_code]
      @order.address     = params[:order][:address]
      @order.name        = params[:order][:name]
      flash[:choose] = "address_new"
    else
      redirect_to request.referer
    end
  end

  def complete
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    if @order.save
      if  flash[:choose] = "address_new"
        @address = Address.new(
          customer_id: current_customer.id,
          postal_code: params[:order][:postal_code],
          address: params[:order][:address],
          name: params[:order][:name]
        )
        @address.save
      end
      @cartitems = current_customer.cart_items
      if @cartitems.count >= 1
      @cartitems.each do |cartitem|
        @order_detail = OrderDetail.new(
              order_id: @order.id,
              item_id: cartitem.item.id,
              amount: cartitem.amount,
              price: cartitem.item.price,
              making_status: 0
            )
            @order_detail.save
        end
          @cartitems.destroy_all
          redirect_to complete_orders_path
      else
        redirect_to new_order_path
      end
    else
      redirect_to new_order_path, flash: { error: @order.errors.full_messages }
    end
  end

  def index
    @orders = current_customer.orders.all
  end

  def show
    if params[:id] = "confirm"
      redirect_to new_order_path
      flash[:r_error] = "??????????????????????????????????????????????????????????????????"
    else
      @order = Order.find(params[:id])
    end
  end
  
  private
  def order_params
    params.require(:order).permit(:payment_method,:postal_code,:address,:name, :shipping_cost, :total_payment, :status)
  end
end
