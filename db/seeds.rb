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

50.times do
  villa = Villa.create(name: Faker::Address.unique.community)

  (Date.parse('2025-01-01')..Date.parse('2025-12-31')).each do |date|
    Calendar.create(
      villa: villa,
      date: date,
      price: rand(30_000..50_000),
      available: [ true, false ].sample
    )
  end
end
