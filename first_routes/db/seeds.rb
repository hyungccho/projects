# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user1 = User.create!(username: "bobby")
user2 = User.create!(username: "jimmy")
user3 = User.create!(username: "tommy")
user4 = User.create!(username: "greggy")

user1contact1 = Contact.create!(name: "Jim", email: "jimmy@jimmy.com", user_id: 1, favorited: true)
user1contact2 = Contact.create!(name: "Tom", email: "tommy@tommy.com", user_id: 1)
user1contact3 = Contact.create!(name: "Greg", email: "greggy@greggy.com", user_id: 1)

user1share = ContactShare.create!(contact_id: 2, user_id: 2, favorited: true)
user1share = ContactShare.create!(contact_id: 3, user_id: 2)

user1comment = Comment.create!(user_id: 1, commentable_id: 1, commentable_type: 'Contact', body: "whatever i want")

group1 = Group.create!(owner_id: 1)

contact1membership1 = GroupMembership.create!(group_id: 1, contact_id: 1)
contact2membership1 = GroupMembership.create!(group_id: 1, contact_id: 2)
