FactoryGirl.define do
	factory :deal do
    sequence(:title)  { |n| "Deal #{n}" }
	end
end
