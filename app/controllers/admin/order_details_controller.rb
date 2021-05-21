class Admin::OrderDetailsController < ApplicationController
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
    #params.permit(:making_status,:customer_id, array: [着手不可: 0, 制作待ち: 1, 制作中: 2, 制作完了: 3])
    params.require(:order_detail).permit(:making_status,:customer_id)
    #params.permit(:making_status, array: [着手不可: 0, 制作待ち: 1, 制作中: 2, 制作完了: 3])
  end
end
