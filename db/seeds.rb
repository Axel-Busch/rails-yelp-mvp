# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

puts "Cleaning database..."
Restaurant.destroy_all


categories = ["chinese", "italian", "japanese", "french", "belgian"]

puts "Creating restaurants..."
10.times do
  restaurant = Restaurant.create!(
    name: Faker::Restaurant.unique.name,
    address: Faker::Address.full_address,
    phone_number: Faker::PhoneNumber.phone_number,
    category: categories.sample
  )

  5.times do
    funny_name = Faker::FunnyName.unique.name
    rating = rand(0..5)
    content = "Review by #{funny_name}: I rate this place a #{rating} because " +
              (rating > 3 ? "the food tickled my taste buds!" : "the waiter forgot me lol!")

    restaurant.reviews.create!(
      rating: rating,
      content: content
    )
  end
end

puts "Finished! Created #{Restaurant.count} restaurants."
