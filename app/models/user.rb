class User < ActiveRecord::Base

  has_secure_password

  has_many :requests, dependent: :destroy 
  has_many :comments, dependent: :destroy 
  has_many :likes, dependent: :destroy
  has_many :prayers, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :liked_requests, through: :likes, :class_name => "Request"
  has_many :prayed_requests, through: :prayers, :class_name => "Request"
  has_many :subscribed_requests, through: :subscriptions, :class_name => "Request"

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
	validates :first_name, :last_name, presence: true, length: { in: 3..20 }
	# validates :password, presence: true, confirmation: true, length: { in: 5..20 }
	# validates :password_confirmation, presence: true, length: { in: 5..20 }
  validates :username, presence:true, uniqueness: { case_sensitive: false }
	validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }

  before_create {generate_token(:auth_token)}

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    PraylistMailer.password_reset(self).deliver
    save!
  
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
end
