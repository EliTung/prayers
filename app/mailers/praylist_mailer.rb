class PraylistMailer < ActionMailer::Base
  default from: "noreply@inhisname-wepray.com"
  
  def praylist(user)
  	@user = user
  	mail(to: @user.email, subject:'InHisName-WePray: PrayList')
  end

  def praise_email(user, request)
    @user = user
    @request = request
    mail(to: @user.email, subject:'InHisName-WePray: Request Praise!')
  end

  def welcome_email(user)
  	@user = user
  	@url  = 'http://inhisname-wepray.com/sessions/new'
  	mail(to: @user.email, subject:'InHisName-WePray: Welcome!')
  end

  def comment_email(user, comment)
  	@user = user
  	@comment = comment
  	mail(to: @user.email, subject:'InHisName-WePray: Request Comment')
  end

  def password_reset(user)
    @user = user
    mail(to: @user.email, subject:'InHisName-WePray: Password Reset')
  end
end
