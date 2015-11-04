class PasswordController < ApplicationController

	def email
	end

	def emailreset
		user = User.find_by(email: params[:email])
		user.send_password_reset if user
		# user.password_reset_sent_at = time.now
		flash[:success] = 'An email has been sent with instructions to reset your password.'
		redirect_to '/sessions/new'
	end

	def new
		@user = User.find_by_password_reset_token!(params[:reset_token])
	end

	def reset
		@user = User.find_by_password_reset_token!(params[:reset_token])	
		if @user.password_reset_sent_at > 2.hours.ago
			flash[:error] = 'Password reset has expired.'
			redirect_to '/users/password/email'
		elsif params[:password] == params[:password_confirmation]
			@user.password = params[:password]
			if @user.save
				flash[:success] = 'You have successfully reset your password'
				redirect_to '/sessions/new'
			end
		else 
			flash[:error] = 'Passwords do not mach'
		end
	end

end
