class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    @order_detail.update(order_detail_params)
    if @order_detail.making_status == "製作中"
    @order.update(status: "製作中")
    redirect_to request.referer
    elsif @order_detail.making_status == "製作完了"
      @order.update(status: "発送準備中")
    redirect_to request.referer
    else
    redirect_to request.referer
    end
  end


  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
