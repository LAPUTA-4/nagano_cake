class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :addresses, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  
  validates :postal_code, presence: true, format: { with: /\A\d{7}\z/ }
  validates :telephone_number, presence: true, format: { with: /\A\d{10,11}\z/ }
end
