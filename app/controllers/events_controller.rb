# frozen_string_literal: true

# The EventsController is responsible for managing events within the application.
# It provides actions to list events, create new events, and delete existing events.
class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def new
    @event = Event.new(hasCountdown: false)
  end

  def create
    @event = Event.new(event_params.merge(hasCountdown: false))

    if @event.save
      redirect_to events_path, notice: 'Event created successfully.'
    else
      render :new
    end
  end

  def new_final_countdown
    @event = Event.new(hasCountdown: true)
  end

  def create_final_countdown
    # Delete all prior final countdown events
    Event.where(hasCountdown: true).destroy_all

    @event = Event.new(event_params.merge(hasCountdown: true))

    if @event.save
      redirect_to events_path, notice: 'Final Countdown Event created successfully.'
    else
      render :new_final_countdown
    end
  end

  def show
    @event = Event.find(params[:id])
    # You can add any logic related to displaying an individual event here.
  end

  def destroy
    @event = Event.find(params[:id])

    # Remove all associated entries in events_users before deleting the event
    @event.users.clear

    @event.destroy
    redirect_to request.referrer || admin_dashboard_path, notice: 'Event was successfully deleted.'
  end

  private

  def event_params
    params.require(:event).permit(:name, :date)
  end
end
