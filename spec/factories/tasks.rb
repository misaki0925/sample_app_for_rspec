FactoryBot.define do
  factory :task do
    title {"Test"}
    content {"Testcontent"}
    status {"todo"}
    deadline{ 1.week.from_now }
    association :user
  end
end
