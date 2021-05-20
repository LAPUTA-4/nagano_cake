class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy
  accepts_nested_attributes_for :order_details
  
  enum payment_method: { クレジットカード払い: 0, 銀行振り込み: 1 }
  enum status: { 入金待ち: 0, 入金確認: 1, 作成中: 2, 発送準備中: 3, 発送済み: 4 }  

end
