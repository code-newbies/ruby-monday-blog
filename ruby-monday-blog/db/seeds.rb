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
        Tag.populate 2 do |tag|
          tag.content = ["Ruby on Rails", "Ruby", "JavaScript", "Ruby Gems", "Angular", "Meteor"]
        end
      end
    end

 #   Post.populate 2 do |post|
 #     post.title = Populator.words(3..7).titleize
 #     post.body  = Populator.sentences(10..20)
 #   end

 #   Tag.populate 20 do |tag|
 #     tag.content = ["Ruby on Rails", "Ruby", "JavaScript", "Ruby Gems", "Angular", "Meteor"]
 #   end
  end
end

