module Api
  module V1
    class EventsController < ApplicationController
      before_action :authorize_request

      # GET /api/v1/events
      def index
        events = policy_scope(Event)
        render json: { success: true, events: events }, status: :ok
      end

      # GET /api/v1/events/:id
      def show
        render json: { success: true, event: event }, status: :ok
      end

      # POST /api/v1/events
      def create
        event = current_user.events.build(event_params)

        autrhorize event

        if event.save
          render json: { success: true, message: "Event created successfully.", event: event }, status: :created
        else
          render json: { success: false, errors: event.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PUT /api/v1/events/:id
      def update
        authorize event

        if event.update(event_params)
          render json: { success: true, message: "Event updated successfully.", event: event }, status: :ok
        else
          render json: { success: false, errors: event.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/events/:id
      def destroy
        authorize event
        
        event.destroy
        render json: { success: true, message: "Event deleted successfully." }, status: :ok
      end

      private

      def event_params
        params.require(:event).permit(:name, :date, :venue, :description)
      end

      def event
        @_event ||= Event.find(params[:id])
      end
    end
  end
end
