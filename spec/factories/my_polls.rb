FactoryGirl.define do
  factory :my_poll do
    association :user, factory: :user 
    expires_at "2017-06-26 08:02:09"
    title "MyString Test"
    description "MyText text kjhaskdjahskdj akjsdhas kajshdkasjd"
  end
end
