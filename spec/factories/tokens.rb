FactoryGirl.define do   
    factory :token do
         expires_at "2017-06-21 7:40:10"
         association :user, factory: :user 
    end    
end    