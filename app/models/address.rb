class Address < ApplicationRecord
    belongs_to :customer
    
    validates :postal_code, presence: true, format: { with: /\A\d{7}\z/ }
    validates :address, presence: true
    validates :name, presence: true
    
    def view_all #テーブルカラムの連結
      '〒' + self.postal_code + '　' + self.address.to_s + '　' + self.name.to_s
    end
end
