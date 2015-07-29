namespace :db do
  desc "Add posts data to views"
  task :seed => :environment do
    require 'populator'
    require 'faker'
    
    User.populate 20 do |user|
      user.email    = Faker::Internet.email
      user.encrypted_password = Faker::Internet.password(8)
      user.sign_in_count = 10..100
      Post.populate 10 do |post|
        post.title = Populator.words(1..3).titleize
        post.body  = Populator.sentences(10..20)
      end
    end

    Tag.populate 20 do |tag|
      tag.content = ["Ruby on Rails", "Ruby", "JavaScript", "Ruby Gems", "Angular", "Meteor"]
    end

    Tag.all.zip(Post.all).each do |pair|
      PostTag.create(tag: pair.first, post: pair.last)
    end
  end
end

