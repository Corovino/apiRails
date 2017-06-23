require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
      
    describe "POST /users" do
        before :each do
            auth = { provider:"facebook", uid:"kjh3h43kgfd", info: { email: "tes@test.com"} }
            post "/api/v1/users", params: { auth: auth }
        end    

        it { have_http_status(200) } 
        
        it { change(User, :count).by(1)} 
        
        it "Response with the user found or created" do 
             json =JSON.parse(response.body)
             puts "----#{json}-----"
             expect(json["email"]).to eq("tes@test.com")
        end     
    end    

end    