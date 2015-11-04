desc 'send digest email'
task send_digest_email: :environment do
  # ... set options if any
  @users = User.all
		@users.each do |user|
			if user.email_subs == true
			PraylistMailer.praylist(user).deliver
			end
			user.subscriptions.each do |subscription|
				if subscription.week_count > 0
					subscription.week_count -= 1
					subscription.save
				end
			end
		end
end