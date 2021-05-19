class Public::AddressesController < ApplicationController
  def index
    customer = Customer.find(current_customer.id)
    @addresses = customer.addresses
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end
end
