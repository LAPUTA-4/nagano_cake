# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create(email: 'a@a.com', password: '111111')
Customer.create(last_name: 'ムスカ', first_name: '大佐', last_name_kana: 'ムスカ', first_name_kana: 'タイサ', address: '飛行船ゴリアテ モールス通信室', postal_code: '1000000', telephone_number: '08022124414', email: 'musuka@laputa.com', password: '111111')
Customer.create(last_name: 'ロボット', first_name: '兵', last_name_kana: 'ロボット', first_name_kana: 'ヘイ', address: '天空の城ラピュタ', postal_code: '1000000', telephone_number: '08022124414', email: 'robot@laputa.com', password: '111111')
Customer.create(last_name: 'シー', first_name: 'タ', last_name_kana: 'シー', first_name_kana: 'タ', address: '天空の城ラピュタ王室正門受付所', postal_code: '1000000', telephone_number: '08022124414', email: 'sheeta@laputa.com', password: '111111')
Customer.create(last_name: 'パ', first_name: 'ズー', last_name_kana: 'パ', first_name_kana: 'ズー', address: '鳩がたくさん住んでる小屋', postal_code: '1000000', telephone_number: '08022124414', email: 'pazu@laputa.com', password: '111111')
Genre.create([
    {name: "ケーキ"},
    {name: "焼き菓子"},
    {name: "プリン"},
    {name: "キャンディ"}
])
Item.create(name: 'ガトーショコラ', genre_id: '1', introduction: 'おいしいおいしいガトーショコラです', price: '450', is_active: true, image: File.open('app/assets/images/cake_1.jpeg'))
Item.create(name: 'イチゴのタルト', genre_id: '1', introduction: 'おいしいおいしいイチゴのタルトです', price: '400', is_active: true, image: File.open('app/assets/images/cake_2.jpeg'))
Item.create(name: 'クッキー', genre_id: '2', introduction: 'おいしいおいしいクッキーです', price: '300', is_active: true, image: File.open('app/assets/images/baked_1.jpeg'))
Item.create(name: 'マカロン', genre_id: '2', introduction: 'おいしいおいしいマカロンです', price: '370', is_active: true, image: File.open('app/assets/images/baked_2.jpeg'))
Item.create(name: 'ベアグミ', genre_id: '4', introduction: 'おいしいおいしいベアグミです', price: '280', is_active: true, image: File.open('app/assets/images/candy_1.jpeg'))
Item.create(name: 'リンゴのロリポップ', genre_id: '4', introduction: 'おいしいおいしいリンゴのロリポップです', price: '180', is_active: true, image: File.open('app/assets/images/candy_2.jpeg'))
Item.create(name: 'ベリーのプリン', genre_id: '3', introduction: 'おいしいおいしいベリーのプリンです', price: '120', is_active: true, image: File.open('app/assets/images/pudding_1.jpg'))
Item.create(name: '皿ごとプリン', genre_id: '3', introduction: 'おいしいおいしい皿ごとプリンです(お皿付き)', price: '560', is_active: true, image: File.open('app/assets/images/pudding_2.jpg'))
CartItem.create(customer_id: '1', item_id: '1', amount: '3')
Order.create(customer_id: '1', postal_code: '1110000', address: '七石山病院', name: 'キキとメイのお母さん', shipping_cost: '800', total_payment: '2285', payment_method: 0, status: 1)
OrderDetail.create(order_id: '1', item_id: '1', price: '1350', amount: '3', making_status: 0)
