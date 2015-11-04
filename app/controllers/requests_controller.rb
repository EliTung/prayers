class RequestsController < ApplicationController
	before_action :require_login, only: [:index, :create, :destroy, :like]
	# after_action :filter_requests, only: [:index]

	def index
		puts params
		@requests = Request.all.where({:result=>nil}).order('updated_at desc').paginate(page: params[:page], per_page: 12)

		if params[:filter]
			case params[:filter]
  			when 'church'
  				@requests = @requests.church(current_user.church)
  				@requests = @requests.campus(current_user.church_campus)
  			when 'city'
  				@requests = @requests.city(current_user.city)
  			when 'search'
  				if !params[:search]
		  			params[:search] = session[:search] 
  	 			else
  					session[:search] = search_params
  					puts params
  				end
  				@requests = @requests.firstname
					filtering_params(search_params).each do |key, value|
						if value == ""
							value = nil
						end
    			@requests = @requests.public_send(key, value) if value.present?
  				end	
  				# session[:search] = nil
  			end
  			@filter = params[:filter]
		end
		@requests = filter_requests(@requests)
		@page = params[:page]
	end

	def praises
		@requests = Request.all.where.not({:result=>nil}).order('updated_at desc').paginate(page: params[:page], per_page: 12)
		
		if params[:filter]
			case params[:filter]
  			when 'church'
  				@requests = @requests.church(current_user.church)
  				@requests = @requests.campus(current_user.church_campus)
  			when 'city'
  				@requests = @requests.city(current_user.city)
  			when 'search'
  				if !params[:search]
		  			params[:search] = session[:search] 
  	 			else
  					session[:search] = search_params
  					puts params
  				end
  				@requests = @requests.firstname
					filtering_params(params).each do |key, value|
						if value == ""
							value = nil
						end
    			@requests = @requests.public_send(key, value) if value.present?
  				end	
  				# session[:search] = nil
  			end
  			@filter = params[:filter]
		end
		@requests = filter_requests(@requests)
		@page = params[:page]
		
		# @requests = Request.where({:result=>nil})
		# @praises = Request.where.not({:result=>nil})
	end

	def comments
		@request = Request.find(params[:id])
		@comments = @request.comments
		puts @request
		puts @comments
	end

	def create
		# @user = User.find(session[:user_id])
		@request = Request.new(
			user: current_user,
			content: params[:content],
			request: params[:request],
			topic: params[:topic],
			firstname: params[:firstname], 
			visible: params[:visible])
		if @request.save
			flash[:success] = 'Your request has been posted!'
			@tab="requests"
			redirect_to "/users/#{session[:user_id]}/#{@tab}"
		else
			flash[:errors] = @request.errors.full_messages
			redirect_to "/users/#{session[:user_id]}"
		end
	end

	def destroy
		@request = Request.find(params[:id])
		@request.destroy if @request.user == current_user
		@tab = "requests"
		redirect_to "/users/#{session[:user_id]}/#{@tab}"
	end

	def update
		@request = Request.find(params[:id])
		@request.content = params[:content]
		@request.request = params[:request]
		@request.topic = params[:topic]
		@request.firstname = params[:firstname]
		if @request.save	
			flash[:success] = "You have successfully updated your request."
		else
			flash[:errors] = @request.errors.full_messages
		end
		@tab = "requests"
		redirect_to "/users/#{session[:user_id]}/#{@tab}"
	end

	def praise
		@request = Request.find(params[:id])
		@request.result = params[:praise]
		if @request.save
			flash[:success] = "Your prayer request has been closed. Thanks for letting everyone know!"
			@request.subscribers.each do |subscriber|
			  if subscriber.email_subs = true
				PraylistMailer.praise_email(subscriber, @request).deliver
			  end	
			end
		else
			flash[:errors] = @request.errors.full_messages
		end
		@tab = "praises"
		redirect_to "/users/#{session[:user_id]}/#{@tab}"
	end

	def comment
		@request = Request.find(params[:id])
		@comment = Comment.new(
			request: @request,
			content: params[:content],
			firstname: params[:firstname], 
			user: current_user)
		if @comment.save
			flash[:success] = 'Your comment has been posted!'
			if @request.user.email_comms == true
			PraylistMailer.comment_email(@request.user, @comment).deliver
			end
			redirect_to "/requests/#{@request.id}/comments"
		else
			flash[:errors] = @comment.errors.full_messages
		end
	end

	def pray
		@request = Request.find(params[:id])
		@prayer = Prayer.find_by(request: @request, user: current_user)
		if @prayer && (@prayer.updated_at < 3.hours.ago)
			@prayer.pr_count += 1
			@prayer.save
			# redirect_to "/requests#req#{params[:id]}"
		elsif @prayer
			flash[:error] = "You have prayed for this request within the last 3 hours. Try to pray for something else!"
		elsif @request.user != current_user
			@newprayer = Prayer.new(
				request: @request, 
				user: current_user,
				pr_count: 1)
			@newprayer.save
		else
			flash[:error] = 'You have already prayed this request'
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

	

	def like
		@request = Request.find(params[:id])
		@like = Like.find_by(request: @request, user: current_user)
		unless @like || @request.user == current_user
			@newlike= Like.new(request: @request, user: current_user)
			@newlike.save
			redirect_to "/requests"
		else
			flash[:error] = 'You have already liked this request'
			redirect_to "/requests"
		end
	end

	def unlike
		@request = Request.find(params[:id])
		@like = Like.find_by(request: @request, user: current_user)
		@like.destroy
		redirect_to "/requests"
	end

	private 

		def filtering_params(params)
	  		params.slice(:first_name, :last_name, :church, :church_campus, :city)	
		end

		def filter_requests(requests)
			requests = requests.scope_church(current_user.church, current_user.church_campus)
			# requests = requests.scope_campus(current_user.church_campus)
			requests = requests.scope_group(current_user.church, current_user.fellowship)
			requests = requests.scope_city(current_user.city)
		end

		def search_params
		  params.require(:search).permit(
	  		:first_name, :last_name, 
	  		:city, :state, :zipcode, 
			:church, :church_campus)
		end
end
