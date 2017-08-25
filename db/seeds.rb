# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

photo1 = 'http://res.cloudinary.com/chikarao/a-team-van_iecmv0'
photo2 = 'http://res.cloudinary.com/chikarao/miura_rmyj9b'
photo3 = 'http://res.cloudinary.com/chikarao/lambo-yamato_ygxp94'
photo4 = 'http://res.cloudinary.com/chikarao/gtr-fire_burxnu'
photo5 = 'http://res.cloudinary.com/chikarao/cobra_nr2qgq'

puts 'seed start!'

user1 = User.new(email: 'dummy@dummy.com', password: '123456')
user1.save
user2 = User.new(email: 'dummy2@dummy.com', password: '123456')
user2.save
user3 = User.new(email: 'dummy3@dummy.com', password: '123456')
user3.save
user4 = User.new(email: 'dummy4@dummy.com', password: '123456')
user4.save
user5 = User.new(email: 'dummy5@dummy.com', password: '123456')
user5.save

car = Car.new(name: 'A-Team Van', make: 'GMC', model: 'Vandura', year: 1983, color: 'black', seats: 8, location: '1005 Beverly Glen, Bel Air', transmission: 'automatic', price: 100, user_id: 1, longitude:
34.0934113, latitude: -118.4410771)

car.remote_photo_url = photo1
car.user = user1
car.save

car = Car.new(name: 'Ferrari Miura', make: 'Ferrari', model: 'Miura', year: 1970, color: 'red', seats: 2, location: '10236 Charing Cross Rd. Bel Air', transmission: 'manual', price: 200, user_id: 2, longitude: 34.076458, latitude: -118.4318042)
car.remote_photo_url = photo2
car.user = user2
car.save

car = Car.new(name: 'Diablo', make: 'Lamborghini', model: 'Diablo', year: 1983, color: 'Green', seats: 8, location: '144 Monovale Dr.Bel Air', transmission: 'automatic', price: 100, user_id: 3, longitude: 34.0818728, latitude: -118.4263422)
car.remote_photo_url = photo3
car.user = user3
car.save

car = Car.new(name: 'Nissan GTR', make: 'Nissan', model: 'GTR', year: 2015, color: 'Black', seats: 4, location: '331 Sage Lane Santa Monica', transmission: 'automatic', price: 100, user_id: 4, longitude: 34.0310818, latitude: -118.5166705)
car.remote_photo_url = photo4
car.user = user4
car.save

car = Car.new(name: 'Lancruiser with the Works', make: 'Toyota', model: 'Landcruiser', year: 2016, color: 'Red', seats: 8, location: 'K29400 Bluewater Dr. Malibu', transmission: 'automatic', price: 100, user_id: 5)
car.remote_photo_url = photo5
car.user = user5
car.save

addresses = ["31340 Mulholland Dr. Beverly Hills", "14046 Aubrey Rd Beverly Hills", "14046 Aubrey Rd Beverly Hills", "1368 Doheny Pl. LA", "3480 Blair Drive Hollywood Hills", "2840 Seattle Dr. W/Hollywood", "2705 Glen Dower Ave Hollywood Hills", "1222 N.Kings Rd.W/Hollywood", "3674 Berry Dr. Studio City"]


for i in 1..9 do
  index = 0
  puts "Happy Scraping! Category #{i} Start!"

  html_file = open("http://xcars.co/carcategory/#{i}")
  html_doc = Nokogiri::HTML(html_file)

  html_doc.search('.mix-details').each do |element|
    car = Car.new

    car.remote_photo_url = element.search('.mix-preview').first.attribute('href').text
    car.model = element.search('.mix-preview').first.attribute('title').text
    car.make = element.search('span').first.children.text
    # car.price =  element.search('.price-location').first.search('.modelcarppp')[1].text
    car.year = element.search('.price-location').first.search('.modelcarppp')[3].text.to_i
    # car. =  element.search('.price-location').first.search('.modelcarppp')[5].text
    car.color = element.search('.price-location').first.search('.modelcarppp')[7].text

    car.location = addresses[index]
    index += 1

    car.seats = rand(2..4)
    trans = rand(1..2)
    car.transmission = "automatic" if trans == 1
    car.transmission = "manual" if trans == 2
    car.user_id = rand(1..5)
    car.price = rand(100..300)
    id = rand(6..1000)

    if Car.exists?(id) != true
      car.id = id
      car.save
    end

  end
  puts "Happy Scraping! Category #{i} Done!"
end

# http://xcars.co/images/xcars/resized/oo2IEEuf.jpg
# Italy
# Toyota
#  200,000 SAR
# 2014
#   24000 Km
#   Black
puts 'seed end'
