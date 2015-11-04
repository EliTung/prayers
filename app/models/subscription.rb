class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :request
  belongs_to :subscribed_requests, :foreign_key => "request_id", :class_name => "Request"

  scope :active, -> {where("week_count > 0")}
  scope :open, -> { joins(:request).where(requests:{result: nil}).references(:requests)}
end
