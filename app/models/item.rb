class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  
  attachment :image
  
  validates :name, presence: true
  validates :price, presence: true, format: { with: /\A[0-9]+\z/ }
end
