class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def update
    @order = Order.find(params[:id])
    @order.update(orders_params)
    @order_detail = @order.order_details
    
    if @order.status == "入金確認"
    @order_detail.update(making_status: "製作待ち")
    redirect_to request.referer
    else
    redirect_to request.referer
    end
    
  end

  private

  def orders_params
    params.require(:order).permit(:status)
  end
end