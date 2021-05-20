class Admin::CustomersController < ApplicationController
  def index
    # ページネーションをつけたいデータに.page(params[:page])を追加 per(10)⇨1ページあたり表示したい数
    @customers = Customer.all.page(params[:page]).per(10)
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to admin_customer_path
  end

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :first_name_kana, :last_name_kana, :postal_code, :address, :telephone_number, :is_deleted)
  end
end
