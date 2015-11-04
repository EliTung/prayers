class Comment < ActiveRecord::Base
  belongs_to :request
  belongs_to :user

  validates :content, presence: true, length: {  minimum: 10 }
  validates :user, presence: true 
end
