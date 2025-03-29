module Api
  module V1
    class BookingsController < ApplicationController
      def index
        bookings = policy_scope(ticket.bookings)
        render json: { success: true, bookings: bookings }, status: :ok
      end

      def show
        authorize booking
        
        render json: { success: true, booking: booking }, status: :ok
      end

      def create
        booking = ticket.bookings.build(booking_params)
        booking.customer = current_user
        booking.event = ticket.event
      
        authorize booking

        if booking.save
          render json: { success: true, message: "Booking created successfully.", booking: booking }, status: :created
        else
          render json: { success: false, errors: booking.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        authorize booking

        booking.destroy
        render json: { success: true, message: "Booking canceled successfully." }, status: :ok
      end

      private

      def booking_params
        params.require(:booking).permit(:quantity)
      end

      def ticket
        @_ticket ||= Ticket.find(params[:ticket_id])
      end

      def booking
        @_booking ||= Booking.find(params[:id])
      end
    end
  end
end
