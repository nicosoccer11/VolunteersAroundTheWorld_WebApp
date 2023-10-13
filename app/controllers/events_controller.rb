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

<<<<<<< HEAD
  def new_final_countdown
    # Check if a final countdown event for the current year already exists
    if Event.exists?(hasCountdown: true, date: Date.current.beginning_of_year..Date.current.end_of_year)
      redirect_to events_path, alert: 'A final countdown event for this year already exists.'
      return
    end

    @event = Event.new(hasCountdown: true)
  end

  def create_final_countdown
    # Check if a final countdown event for the current year already exists
    if Event.exists?(hasCountdown: true, date: Date.current.beginning_of_year..Date.current.end_of_year)
      redirect_to events_path, alert: 'A final countdown event for this year already exists.'
      return
    end

    @event = Event.new(event_params.merge(hasCountdown: true))

    if @event.save
      redirect_to events_path, notice: 'Final Countdown Event created successfully.'
    else
      render :new_final_countdown
    end
=======
  def show
    @event = Event.find(params[:id])
    # You can add any logic related to displaying an individual event here.
>>>>>>> e0040a09a078848cb075caac909ea8337c3de406
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
