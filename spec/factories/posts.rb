# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    title 'This is a test post title'
    description 'This is a Description for the test post'
    content 'Content for the test post'
  end
end
