class Api::V1::UsersController < ApplicationController

def create
    
    if !params[:auth]
        render json: { error: "Auth params is missing" }
    else
        @user = User.from_omniauth(params[:auth])
        @token = Token.create(user: @user)
        render "api/v1/users/show"
    end
    
end                

end    
