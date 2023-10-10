# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.create(
  first_name: 'John',
  last_name: 'Doe',
  email: 'test@tamu.edu',
  isAdmin: true # Set the isAdmin attribute as needed
)
User.create(
  first_name: 'Johnny',
  last_name: 'Boy',
  email: 'test2@tamu.edu',
  isAdmin: false # Set the isAdmin attribute as needed
)
Classification.create(name: 'Freshman')
Classification.create(name: 'Sophomore')
Classification.create(name: 'Junior')
Classification.create(name: 'Senior')
Classification.create(name: 'Super Senior')
Classification.create(name: 'Grad Student')