FactoryGirl.define do
  factory :activity do
    activity_type "call"
    done true
    note "I'm done!"
    marked_as_done_time "2014-10-16 09:38:04"
    user
    deal
  end
end
