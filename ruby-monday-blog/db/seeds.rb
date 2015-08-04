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
      Post.populate 2 do |post|
        post.title = Populator.words(3..7).titleize
        post.body = Populator.sentences(10..20)
      end
    end

    tags_list.each do |topic|
      Tag.populate 1 do |tag|
        tag.content = topic
      end
    end

    Post.all.each do |entry|
      PostTag.create(post: entry, tag: Tag.all.sample)
    end
  end
end

