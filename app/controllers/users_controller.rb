class UsersController < ApplicationController
  	def new
  		reset_session
  	end

  	def create
  		user = User.new(user_params)
	    if user.save
			flash[:message] = 'You signed up!'
			redirect_to '/'
	    else
	    	flash[:error] = 'Something went wrong!'
			redirect_to '/'
	    end
  	end

  	def show
  		@user = User.find(session[:user_id])
  	end

  	def update
  		user = User.update(session[:user_id], user_update)
  		redirect_to '/events'
  	end

	private

	def user_params
		params.require(:user).permit(:first_name, :last_name, :email, :location, :state, :password, :password_confirmation)
	end

	def user_update
		params.permit(:first_name, :last_name, :email, :location, :state)
	end
end
