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

User.create(
  email: "admin@mail.com",
  name: "admin",
  password: "password",
  admin: true
)

15.times do |i|
  Tag.create(name: FFaker::BaconIpsum.word + i.to_s)
end

60.times do
  Article.create(
    title: FFaker::BaconIpsum.sentence,
    body: FFaker::BaconIpsum.paragraph,
    author_id: User.all.sample.id,
    tags: Tag.all.sample(rand(1..6))
  )
end

120.times do
  Comment.create(
    body: FFaker::Lorem.sentence,
    article_id: Article.all.sample.id,
    author_id: User.all.sample.id,
    parent_id: nil
  )
end

120.times do
  c = Comment.new(
    body: FFaker::Lorem.sentence,
    parent_id: Comment.all.sample.id,
    author_id: User.all.sample.id
  )
  c.article_id = Comment.find(c.parent_id).article.id
  c.save
end

180.times do
  Rating.create(
    author_id: User.all.sample.id,
    article_id: Article.all.sample.id,
    rate: (0..10).step(0.5).to_a.sample
  )
end

180.times do
  Bookmark.create(
    user_id: User.all.sample.id,
    article_id: Article.all.sample.id
  )
end
