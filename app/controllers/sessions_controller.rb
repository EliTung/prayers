class SessionsController < ApplicationController

	def index
	end

	def create
		# puts params
		user = User.find_by(email: params[:email])
		# puts user
		puts 'great'
		if user && user.authenticate(params[:password])
    # if user 
      session[:user_id] = user.id
      # cookies.permanent[:auth_token] = user.auth_token
      redirect_to "/users/#{user.id}"
    else
      flash[:error] = 'Invalid email/password combination'
      redirect_to '/sessions/new'
    end
	end

	def destroy
		# cookies.delete[:auth_token]
		session[:user_id] = nil
    	redirect_to '/sessions/new'
	end


end
