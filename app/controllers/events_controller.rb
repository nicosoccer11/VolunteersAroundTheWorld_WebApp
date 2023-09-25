class EventsController < ApplicationController
    def index
      @events = Event.all
    end

    def new
        @event = Event.new
    end

    def create
        @event = Event.new(event_params)

        if @event.save
            redirect_to events_path, notice: "Event created successfully."
        else
            render :new
        end
    end

    def destroy
        @event = Event.find(params[:id])
        @event.destroy
        redirect_to request.referrer || admin_dashboard_path, notice: 'Event was successfully deleted.'
      end
      
      
      
    private

    def event_params
        params.require(:event).permit(:name, :date)
    end

  end