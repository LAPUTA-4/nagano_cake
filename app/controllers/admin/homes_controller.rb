class Admin::HomesController < ApplicationController
  #def top
  # @orders = Order.all.page(params[:page]).per(10)
  #end
  
  def top
    if params[:customer_id] == nil
      @orders = Order.all
    else
      @orders = Customer.find(params[:customer_id]).orders
    end
  end
  
end
