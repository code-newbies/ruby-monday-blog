# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime
#  updated_at             :datetime
#  role                   :integer
#  first_name             :string
#  last_name              :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

FactoryGirl.define do
  sequence :email do |n|
    "#{n}@example.com"
  end

  factory :user do
    email
    password 'password'
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }

    trait :author do
      role :author
    end

    trait :reader do
      role :reader
    end

    trait :admin do
      role :admin
    end

    factory :author, traits: [:author]
    factory :reader, traits: [:reader]
    factory :admin,  traits: [:admin]
  end
end
