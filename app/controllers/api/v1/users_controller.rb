module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :authorize_request
      
      def create
        user = User.new(user_params)

        if user.save
          render json: { 
            success: true, 
            message: "User registered successfully."
          }, status: :created
        else
          render json: { 
            success: false,
            errors: user.errors.full_messages 
          }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
      end
    end
  end
end
