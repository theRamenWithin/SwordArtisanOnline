class TokensController < ApplicationController
    # If the user is signed in, this creates a token to be used with the Twilio app to pass to Programmable Chat and setup a chatroom.
    def create
        if user_signed_in?
            # Define User Identity
            identity = current_user.email
        
            # Create Grant for Access Token
            grant = Twilio::JWT::AccessToken::ChatGrant.new
            grant.service_sid = Rails.application.credentials.twilio[:chat_service_sid]
        
            # Create an Access Token
            token = Twilio::JWT::AccessToken.new(
                Rails.application.credentials.twilio[:account_sid],
                Rails.application.credentials.twilio[:api_key],
                Rails.application.credentials.twilio[:api_secret],
                [grant],
                identity: identity
            )
        
            # Generate the token and send to client
            render json: { identity: identity, token: token.to_jwt }
        end
    end
end
