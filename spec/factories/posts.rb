# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    title 'Post title'
    description 'Post description'
    content 'Post content'
  end
end
