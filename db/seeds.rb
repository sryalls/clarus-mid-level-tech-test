# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Product.find_or_create_by(description: 'Widgets', code: 'WDGT')
Product.find_or_create_by(description: 'Dohickeys', code: 'DHKY')
Product.find_or_create_by(description: 'Thingamyjigs', code: 'TMYG')

Warehouse.find_or_create_by(code: 'ABC123')
Warehouse.find_or_create_by(code: 'XYZ789')
