class Prayer < ActiveRecord::Base
  belongs_to :user
  belongs_to :request
  belongs_to :prayed_requests, :foreign_key => "request_id", :class_name => "Request"
end
