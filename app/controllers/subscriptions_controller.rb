class SubscriptionsController < ApplicationController

	def create
		@request = Request.find(params[:id])
		@subscription = Subscription.find_by(request: @request, user: current_user)
		unless @subscription || @request.user == current_user
			@new_subscription= Subscription.new(
				request: @request, 
				user: current_user,
				week_count: current_user.subs_frq)
			@new_subscription.save
			flash[:success] = "Thanks, You have just subscribed to this prayer request"
		else
			flash[:error] = 'You have already subscribed to this request'
		end
		if params[:filter]
			@something = params[:filter]
			case params[:filter]
			  when 'church'
					redirect_to "/requests/church/#{params[:page]}#req#{params[:id]}"
			  when 'city'
					redirect_to "/requests/city/#{params[:page]}#req#{params[:id]}"
			  when 'comment'
			  		redirect_to "/requests/#{params[:id]}/comments"
			  when  'search'
				  	redirect_to "/requests/search/#{params[:page]}#req#{params[:id]}"
			  else
			  		redirect_to "/requests/all/#{params[:page]}#req#{params[:id]}"
			  end
		else
			redirect_to "/requests/all/#{params[:page]}#req#{params[:id]}"
		end
	end	

	def renew
		@request = Request.find(params[:id])
		@subscription = Subscription.find_by(request: @request, user: current_user)
		@subscription.week_count= current_user.subs_frq
		@subscription.save
		@tab = 'subscriptions'
		flash[:sucess] = 'Your subscription has been renewed.'
		redirect_to "/users/#{session[:user_id]}/#{@tab}"
	end	
	
	def decr
		@request = Request.find(params[:id])
		@subscription = Subscription.find_by(request: @request, user: current_user)
		if @subscription.week_count != 0
			@subscription.week_count -= 1
		end
		@subscription.save
		@tab = 'subscriptions'
		redirect_to "/users/#{session[:user_id]}/#{@tab}"
	end	

	def incr
		@request = Request.find(params[:id])
		@subscription = Subscription.find_by(request: @request, user: current_user)
		@subscription.week_count += 1
		@subscription.save
		@tab = 'subscriptions'
		redirect_to "/users/#{session[:user_id]}/#{@tab}"
	end	

	def destroy
		@request = Request.find(params[:id])
		@subscription = Subscription.find_by(request: @request, user: current_user)
		@subscription.destroy
		flash[:success] = 'Your prayer subscription has been removed!'
		redirect_to "/users/#{session[:user_id]}/#{@tab}"
	end
end
