# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "Seeding Data ..."

# Helper functions
def open_asset(file_name)
  File.open(Rails.root.join('db', 'seed_assets', file_name))
end

# Only run on development (local) instances not on production, etc.
# unless Rails.env.development?
#   puts "Development seeds only (for now)!"
#   exit 0
# end

# Let's do this ...

## CATEGORIES

puts "Finding or Creating Categories ..."

cat1 = Category.find_or_create_by! name: 'Apparel'
cat2 = Category.find_or_create_by! name: 'Electronics'
cat3 = Category.find_or_create_by! name: 'Furniture'
cat4 = Category.find_or_create_by! name: 'Sustenance'

## PRODUCTS

puts "Re-creating Products ..."

Product.destroy_all

cat1.products.create!({
  name:  'Men\'s Classy shirt',
  description: Faker::Hipster.paragraph(4),
  image: open_asset('https://s3-us-west-2.amazonaws.com/heroku-jungle/apparel1.jpg?X-Amz-Date=20161213T135003Z&X-Amz-Expires=300&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Signature=862e79a49929a2842a8c998f8f29471619499fecb9d9ca43e9cbac5c312dc05c&X-Amz-Credential=ASIAJFNLUI6ELSDJO6SA/20161213/us-west-2/s3/aws4_request&X-Amz-SignedHeaders=Host&x-amz-security-token=FQoDYXdzEJ7//////////wEaDHjo%2B5WPlb6/dbZvoSL6AYCPOjS1WMU6Y656cnaC1Wgx6HTM%2By1V85RLM7r9Iwcthn0ArjdII6kTgu1ZxgE///Sqd/gZjZZF89mHjInV3CaYxO5/br8SyuPBJlY2P/Rb8wkUovoaDH9Yvumi3k5fCEUHZ6dMuifolpV4B60%2BmqiixBnzEw3Cz%2BhGw68/VSW4vXQr1p1FCufgJzGFavUEQSXuqCrprQ%2B3KaBTJU0SWXyictgdcLQ0T6zDuDb5joTmqHQHkkVzbQcRCtsFGMt3xyf7QPgVEFIH3Mu7xzijBmMp9H1pCaoG22Ovx7OWud15BbjUZJzsUvuCH6suuyw/cVPLpGakioKX0%2B8og/29wgU%3D'),
  quantity: 10,
  price: 64.99
})

cat1.products.create!({
  name:  'Women\'s Zebra pants',
  description: Faker::Hipster.paragraph(4),
  image: open_asset('apparel2.jpg'),
  quantity: 18,
  price: 124.99
})

cat1.products.create!({
  name:  'Hipster Hat',
  description: Faker::Hipster.paragraph(4),
  image: open_asset('apparel3.jpg'),
  quantity: 0,
  price: 34.49
})

cat1.products.create!({
  name:  'Hipster Socks',
  description: Faker::Hipster.paragraph(4),
  image: open_asset('apparel4.jpg'),
  quantity: 8,
  price: 25.00
})

cat1.products.create!({
  name:  'Russian Spy Shoes',
  description: Faker::Hipster.paragraph(4),
  image: open_asset('apparel5.jpg'),
  quantity: 8,
  price: 1_225.00
})

cat1.products.create!({
  name:  'Human Feet Shoes',
  description: Faker::Hipster.paragraph(4),
  image: open_asset('apparel6.jpg'),
  quantity: 82,
  price: 224.50
})


cat2.products.create!({
  name:  'Modern Skateboards',
  description: Faker::Hipster.paragraph(4),
  image: open_asset('electronics1.jpg'),
  quantity: 40,
  price: 164.49
})

cat2.products.create!({
  name:  'Hotdog Slicer',
  description: Faker::Hipster.paragraph(4),
  image: open_asset('electronics2.jpg'),
  quantity: 3,
  price: 26.00
})

cat2.products.create!({
  name:  'World\'s Largest Smartwatch',
  description: Faker::Hipster.paragraph(4),
  image: open_asset('electronics3.jpg'),
  quantity: 32,
  price: 2_026.29
})

cat3.products.create!({
  name:  'Optimal Sleeping Bed',
  description: Faker::Hipster.paragraph(4),
  image: open_asset('furniture1.jpg'),
  quantity: 320,
  price: 3_052.00
})

cat3.products.create!({
  name:  'Electric Chair',
  description: Faker::Hipster.paragraph(4),
  image: open_asset('furniture2.jpg'),
  quantity: 2,
  price: 987.65
})

cat3.products.create!({
  name:  'Red Bookshelf',
  description: Faker::Hipster.paragraph(4),
  image: open_asset('furniture3.jpg'),
  quantity: 23,
  price: 2_483.75
})

cat4.products.create!({
  name: 'Can of Tuna',
  description: 'Tuna, in a can!',
  image: open_asset('tuna.jpg'),
  quantity: 0,
  price: 28.00
  })

## USERS

puts "Creating a few users - use t@t.com for admin testing, password '1'"
puts "...for non-admin use h@h.com, same password"

User.destroy_all

User.create!({
  first_name: 'Testy',
  last_name: 'Testerson',
  email: 't@t.com',
  password_digest: '$2a$10$r01N1PZuX3cYkhKD.PvnCOePI6jHH1V2/1trahxYUb8nUwrBsAo76',
  admin: true
  })

User.create!({
  first_name: 'Hippy',
  last_name: 'Hipsterson',
  email: 'h@h.com',
  password_digest: '$2a$10$DxnlH.mcHrzJwmyJ6lpOfe3L/KMHwq7u2.G/TQxcC.cGFb86nLcM2',
  admin: false
  })

## REVIEWS

puts 'Creating some initial reviews'

Rating.destroy_all

Rating.create!({
  product_id: 4,
  user_id: 2,
  description: 'So great!',
  rating: 4
  })

Rating.create!({
  product_id: 3,
  user_id: 2,
  description: "It's the worst thing since the pre-mustache era",
  rating: 1
  })

Rating.create!({
  product_id: 7,
  user_id: 2,
  description: "Not really sure it's hipster enough",
  rating: 3
  })

Rating.create!({
  product_id: 10,
  user_id: 2,
  description: 'perfect, I want to marry it',
  rating: 5
  })


puts "DONE!"
