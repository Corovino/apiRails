require 'rails_helper'

RSpec.describe User, type: :model do
    it{ should validate_presence_of(:email) }
    it{ should_not allow_value("hebert@email").for(:email) }
    it{ should allow_value("hebert@email.com").for(:email) }
    it{ should validate_presence_of(:uid) }
    it{ should validate_presence_of(:provider) }
    

    it "User deberia crear un usuario si el uid y el provider no existen" do
        expect{
            User.from_omniauth({uid:"1234567", provider:"gmail", info:{ email:"hjr@gmail.xyz" } } )
        }.to change(User,:count).by(1)
    end 

    it "User deberia encontrar un usuario si el uid y el provider ya existen" do
        user = FactoryGirl.create(:user)
        #llaves de claro bloque sin esperar valor de retorno
        expect{
            User.from_omniauth({uid:user.uid, provider:user.provider} )
        }.to change(User,:count).by(0)
    end    

    it "User deberia retornar el usuario si ya existe" do
        user = FactoryGirl.create(:user)
        # parentesis espera un valor de retorno.
        expect( 
            User.from_omniauth({uid:user.uid, provider:user.provider})
        ).to eq(user) 
    end    
end     