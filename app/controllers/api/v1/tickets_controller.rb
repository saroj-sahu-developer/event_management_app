module Api
  module V1
    class TicketsController < ApplicationController
      def index
        tickets = policy_scope(event.tickets)
        render json: { success: true, tickets: tickets }, status: :ok
      end

      def show
        authorize ticket
        
        render json: { success: true, ticket: ticket }, status: :ok
      end

      def create
        ticket = event.tickets.build(ticket_params)
        authorize ticket

        if ticket.save
          render json: { success: true, message: "Ticket created successfully.", ticket: ticket }, status: :created
        else
          render json: { success: false, errors: ticket.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        authorize ticket

        if ticket.update(ticket_params)
          render json: { success: true, message: "Ticket updated successfully.", ticket: ticket }, status: :ok
        else
          render json: { success: false, errors: ticket.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        authorize ticket

        ticket.destroy
        render json: { success: true, message: "Ticket deleted successfully." }, status: :ok
      end

      private

      def ticket_params
        params.require(:ticket).permit(:ticket_type, :price, :quantity_available)
      end

      def event
        @_event ||= Event.find(params[:event_id])
      end

      def ticket
        @_ticket ||= event.tickets.find(params[:id])
      end
    end
  end
end
