class Address < ApplicationRecord
    belongs_to :customer
    def view_all #テーブルカラムの連結
      '〒' + self.postal_code + '　' + self.address.to_s + '　' + self.name.to_s
    end
end
