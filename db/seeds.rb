# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

%w[Riczi Luke Han Leia Golum Frodo Gandalf Sauron].map do |name|
  User.create(
    email: "#{name}@mail.com",
    name: name,
    password: "password"
  )
end

15.times do |i|
  Tag.create(name: FFaker::BaconIpsum.word + i.to_s)
end

150.times do |index|
  Article.create(
    title: FFaker::BaconIpsum.sentence,
    body: FFaker::BaconIpsum.paragraph,
    author_id: User.all.sample.id,
    tags: Tag.all.sample(rand(1..6))
  )
end
