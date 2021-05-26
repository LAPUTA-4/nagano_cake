class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  def top
    if params[:customer_id] == nil
      @orders = Order.all
    else
      @orders = Customer.find(params[:customer_id]).orders
    end
  end
  
end
