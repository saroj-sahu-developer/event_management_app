module Api
  module V1
    class AuthenticationController < ApplicationController
      skip_before_action :authorize_request
      
      def login
        user = User.find_by(email: params[:email])

        if user&.authenticate(params[:password])
          token = JsonWebToken.encode(user_id: user.id)
          render json: { success: true, token: token}, status: :ok
        else
          render json: { success: false, error: 'Invalid email or password' }, status: :unauthorized
        end
      end
    end
  end
end
