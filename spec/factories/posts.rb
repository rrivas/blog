# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    sequence(:title) { |n| "post title #{n}" }
    description 'This is a Description for the test post'
    content 'Content for the test post'
  end
end
