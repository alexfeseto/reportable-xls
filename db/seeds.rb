# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u = User.new(name: 'nilakanta@gmail.com', email: 'nilakanta@gmail.com', admin: true)
u.password = u.password_confirmation = 'nilakanta'
u.save!
u = User.new(name: 'alex@reportablesystems.com', email: 'alex@reportablesystems.com', admin: true)
u.password = u.password_confirmation = 'alexander'
u.save!