class UsersController < ApplicationController
	before_action :require_login, except: [:new, :create]
	before_action :require_correct_user, only: [:show, :edit, :update, :destroy]

	def new
	end

	def edit
	end

	def password
	end

	def show
		@requests = User.find(session[:user_id]).requests.where({:result=>nil}).reverse_order
		@praise_requests = User.find(session[:user_id]).subscribed_requests.where.not({:result=>nil}).reverse_order
		@subscriptions = User.find(session[:user_id]).subscriptions.open.reverse_order
		if params[:tab]
			@tab = params[:tab]
		else
			@tab = 'subscriptions'
		end
	end

	def create
		puts params
		@user = User.create(
			email: params[:email],
			username: params[:username],
			first_name: params[:first_name],
			last_name: params[:last_name],
			city: params[:city],
			state: params[:state],
			password: params[:password],
			password_confirmation: params[:password_confirmation],
			church: params[:church],
			church_campus: params[:church_campus],
			zipcode: params[:zip],
			subs_frq: 3,
			email_subs: false,
			email_prays: false,
			email_comms: false)
		if@user.save
			PraylistMailer.welcome_email(@user).deliver
			flash[:success] = "You have successfully registered. Please log in!"
			redirect_to '/sessions/new'
		else
			flash[:errors] = @user.errors.full_messages
			# @error["name"] = @user.errors[:first_name]
			@first_name = @user.errors[:first_name]
			redirect_to '/users/new'
		end
	end

	def update
		puts params
		@user = User.find(params[:id])
		puts @user
		@user.update(user_params)
		if @user.save
			flash[:success] = "Your profile information and settings have been successfully updated."
			redirect_to "/users/#{current_user.id}"
		else
			flash[:message] = @user.errors
			puts @user.errors
			redirect_to "/users/#{current_user.id}/edit"
		end	
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy
		flash[:error] = 'Your account has been deleted'
		redirect_to "/sessions/new"
	end

	def passchange
		user = User.find(current_user.id)
		# puts user
		puts 'great'
		if user && user.authenticate(params[:password])
    # if user 
    	if params[:password] == params[:password_confirmation]
	      user.password = params[:password_new]
	      if user.save
	      	flash[:success] = "Your password has been successfully reset"
	      	redirect_to "/users/#{user.id}/edit"
	      else
	      end
	    else
	    	flash[:error] = "Password and password confirmation don't match"
    	end
    else
      flash[:error] = 'Invalid email/password combination'
      redirect_to '/users/password'
    end
	end



	private

		def user_params
		  params.require(:user).permit(
	  	:first_name, :last_name, 
	  	:email, :username, 
			:city, :state, :zipcode, 
			:church, :church_campus, :fellowship,
			:subs_frq, :email_subs, :email_prays, :email_comms)
		end
end
