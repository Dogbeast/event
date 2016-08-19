class CommentsController < ApplicationController
	def create
		event = Event.find(params[:id])
		comment = Comment.new(comment: params[:comment], event: event)
		if comment.save
			flash[:comment] = "Comment saved!"
			redirect_to "/events/#{params[:id]}"
		else
			flash[:error] = "Comment was empty!"
			redirect_to "/events/#{params[:id]}"
		end
	end
end
