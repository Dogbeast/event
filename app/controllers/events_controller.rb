class EventsController < ApplicationController
  def index
  	@user = User.find(session[:user_id])
  	@myEvents = Event.where(state: @user.state)
  	@outsideEvents = Event.where.not(state: @user.state)
  end

  def show
  	@event = Event.find(params[:id])
  	@comments = @event.comments.all
  end

  def create
  	event = Event.new(event_params)
  	if event.valid? and event.date.future?
  		event.save
  		user = User.find(session[:user_id])
  		JoinTable.create(user: user, event: event)
		flash[:message] = 'Event added!'
		redirect_to '/events'
    else
    	flash[:error] = 'Something went wrong!'
		redirect_to '/events'
    end
  end

  def join
  	user = User.find(session[:user_id])
  	event = Event.find(params[:id])
  	join = JoinTable.new(user: user, event: event)
  	if join.save
  		flash[:message] = 'You joined the event!'
  		redirect_to '/events'
  	else
  		flash[:error] = 'You failed to join!'
  		redirect_to '/events'
  	end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    event = Event.update(params[:id], event_update)
    redirect_to "/events/edit/#{params[:id]}"
  end

  def delete
  	Event.find(params[:id]).destroy
  	redirect_to '/events'
  end

  def cancel
  	user = User.find(session[:user_id])
  	eventJoined = JoinTable.find_by(user: user)
  	eventJoined.destroy
  	redirect_to '/events'
  end

  private

  def event_params
  	params.require(:event).permit(:name, :date, :location, :state)
  end

  def event_update
    params.permit(:name, :date, :location)
  end
end
