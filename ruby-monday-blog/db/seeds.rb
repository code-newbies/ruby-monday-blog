namespace :db do
  desc "Add posts data to views"
  task :seed => :environment do
    require 'populator'
    require 'faker'

    tags_list = ["Ruby on Rails", "Ruby", "JavaScript", "Angular"]
    [User, Post, Tag].each(&:delete_all)

    User.populate 10 do |user|
      user.email    = Faker::Internet.email
      user.encrypted_password = Faker::Internet.password(8)
      user.sign_in_count = 10..100
      user.first_name = Faker::Name.first_name
      user.last_name  = Faker::Name.last_name
      Post.populate 2 do |post|
        post.title = Populator.words(3..7).titleize
        post.body = Populator.sentences(10..20)
        post.author_id = user.id
      end
    end

    tags_list.each do |topic|
      Tag.populate 1 do |tag|
        tag.content = topic
      end
    end

    Post.all.each do |entry|
      Tag.all.sample(rand(1..tags_list.length)).each do |tag|
        PostTag.create(post: entry, tag: tag)
      end
    end
  end
end
