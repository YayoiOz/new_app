# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(name: "てすと　ようこ", email: "test@test", password: "rubytest", profile: "テストです")
User.create(name: "さむらい　たろう", email: "test@test.ne.jp", password: "rubytest", profile: "テストです")

  (1..10).each do |i|
    User.create!( name: "名前#{i}", email: "test#{i}@test", password: "#{i}123456", profile: "#{i}")
  end
  
  User.all.each do |user|
    user.contents.create!(
      body: 'これはテストです')
  end
  
    User.all.each do |user|
    user.contents.create!(
      body: '4月13日、良い天気ですね。')
  end