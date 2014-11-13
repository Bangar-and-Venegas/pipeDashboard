FactoryGirl.define do
	factory :user do
    sequence(:name)  { |n| "Mr. Number #{n}" }
    sequence(:id)  { |n| n }
	end
end
