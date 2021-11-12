# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin = User.new(
  email: "admin@admin.com",
  password: "adminadmin",
  name: 'Admin',
  role: 'admin'
  )
admin.skip_confirmation!
admin.save!

user = User.new(
  email: "user@user.com",
  password: "useruser",
  name: 'User',
  role: 'user'
  )
user.skip_confirmation!
user.save! 