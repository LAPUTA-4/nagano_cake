class Admin::CustomersController < ApplicationController
  def index
    # ページネーションをつけたいデータに.page(params[:page])を追加 per(10)⇨1ページあたり表示したい数
    @customers = Customer.all.page(params[:page]).per(10)
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
  end

  def update
  end
end
