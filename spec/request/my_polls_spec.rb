require 'rails_helper'

RSpec.describe Api::V1::MyPollsController, type: :request do 

	describe "GET /polls" do

		before :each do
			FactoryGirl.create_list(:my_poll, 10)
			get "/api/v1/polls"
		end	

		it { have_http_status(200) }

		it "Mande la listas de encuetas" do 
			json= JSON.parse(response.body)			
			expect(json.length).to eq(MyPoll.count)
		end	
	end	

	describe "GET /polls/:id" do

		before :each do
			@poll = FactoryGirl.create(:my_poll)
			id = @poll.id
			get "/api/v1/polls/#{id}"
		end	
     
		it { have_http_status(200) }

		it "Mande la encuesta solicitada" do 
			json= JSON.parse(response.body)
			
			expect(json["id"]).to eq(@poll.id)
		end	

		it "manda los atributos de la encuesta" do 
			json= JSON.parse(response.body)
			#puts "--#{json}----"
			expect(json.keys).to contain_exactly("id","title", "description", "user_id", "expires_at")
		end	

	end

	describe "POST /polls" do 

		context "Con token válido" do
			before :each do
				@token = FactoryGirl.create(:token, expires_at: DateTime.now + 10.minutes)
				puts "|--#{@token.inspect}--"
			    post "/api/v1/polls", :params => { token: @token.token, poll: { title: "Test post con 10 caracteres", description: "asdasd asd asd asd asd", expires_at: DateTime.now } }
			    
			end

			it{ have_http_status(200)}    
			it "Crea nueva encuesta" do
				expect{
					post "/api/v1/polls",:params => { token: @token.token, poll:  { title: "Test post con 10 caracteres", description: "asdasd asd asd asd asd", expires_at: DateTime.now } }
				}.to change(MyPoll,:count).by(1)
		    end
		    it "reponde con la cuenta creada" do
		    	json = JSON.parse(response.body)
		    	puts "!--#{json}--"
		    	expect(json["title"]).to eq("Test post con 10 caracteres")
		    end		
		end	

	    
	    context "Con token inválido" do
	    	#before :each do
			 #   post "/api/v1/polls"
			#end
	    end		

	end	

  

end