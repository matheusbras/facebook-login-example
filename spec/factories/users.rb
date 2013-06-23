# Read about factories at https://github.com/thoughtbot/factory_girl
require 'ffaker'

FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    access_token "--token--"
    provider "facebook"
    photo_url "http:/url.com"
    uid "123456"
  end
end