class ApplicationController < ActionController::Base
  #protect_from_forgery with: :exceptio
#callback en rails  que me dice antes de cualquier petición  autentique al usuario
 #before_action :authenticate

  def authenticate
    token_str = params[:token]
    token = Token.find_by(token: token_str)

    if token.nil? || !token.is_valid?
       reder json: { error: "Token is invalid", status: :unaudthrized }
    else
      @current_user = token.user
    end    

  end  


end
