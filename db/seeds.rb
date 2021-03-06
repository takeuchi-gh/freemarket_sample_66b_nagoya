# require "csv"

# CSV.foreach('db/brand.csv') do |row|
#   Brand.create(:name => row[0])
# end

# CSV.foreach('db/category.csv') do |row|
#   Category.create(:name => row[0], :parent_id => row[1])
# end

10.times do |i|
  Item.create!(
    name: "レディースItem #{i+1}",
    size: 2,
    price: 12345,
    seller_id: 1,
    brand_id: 50
    ,
    category_id: 170,
    status: 1,
    charge: 1,
    trade_step: 1,
    delivery: 0,
    prefecture: 3,
    term: 1,
    item_text: "text"
  )
end
10.times do |i|
  Item.create!(
    name: "メンズItem #{i+1}",
    size: 2,
    price: 12345,
    seller_id: 1,
    brand_id: 34,
    category_id: 350,
    status: 1,
    charge: 1,
    trade_step: 1,
    delivery: 0,
    prefecture: 3,
    term: 1,
    item_text: "text"
  )
end
10.times do |i|
  Item.create!(
    name: "ホビーItem #{i+1}",
    size: 2,
    price: 12345,
    seller_id: 1,
    brand_id: 12,
    category_id: 770,
    status: 1,
    charge: 1,
    trade_step: 1,
    delivery: 0,
    prefecture: 3,
    term: 1,
    item_text: "text"
  )
end
10.times do |i|
  Item.create!(
    name: "家電Item #{i+1}",
    size: 2,
    price: 12345,
    seller_id: 1,
    brand_id: 45,
    category_id: 960,
    status: 1,
    charge: 1,
    trade_step: 1,
    delivery: 0,
    prefecture: 3,
    term: 1,
    item_text: "text"
  )
end