class Request < ActiveRecord::Base
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :prayers, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  
  has_many :pr_users, through: :prayers, source: :user
  has_many :lk_users, through: :likes, source: :user
  has_many :subscribers, through: :subscriptions, source: :user
  
  validates :content, presence: true, length: {  minimum: 12 }
  validates :request, presence: true, length: {  minimum: 8 }
  validates :user, presence: true 

  scope :firstname, -> {where firstname: true}
  scope :first_name, -> (first_name) { joins(:user).where(users:{first_name: first_name}).references(:users) }
  scope :last_name, -> (last_name) { joins(:user).where(users:{last_name: last_name}).references(:users)}
  # scope :church_campus, -> (church, church_campus) { joins(:user).where(users:{church: church, church_campus: church_campus}).references(:users)}
  scope :church, -> (church) { joins(:user).where(users:{church: church}).references(:users)}
  scope :campus, -> (church_campus) {joins(:user).where(users:{church_campus: church_campus}).references(:users) }
  scope :city, -> (city) { joins(:user).where(users:{city: city}).references(:users)}
 
  scope :scope_group, -> (church, group) { joins(:user).where("visible <> 'fellowship' OR (visible = 'fellowship' AND (users.church =? AND users.fellowship = ?))", church, group) }
  # scope :scope_group_church, -> (church) { joins(:user).where("visible <> 'fellowship' OR (visible = 'fellowship' AND users.church = ?)", church) }
  scope :scope_church, -> (church, church_campus) { joins(:user).where("visible <> 'church' OR (visible = 'church' AND (users.church = ? AND users.church_campus= ?))", church, church_campus) }
  # scope :scope_campus, -> (campus) { joins(:user).where("visible <> 'church' OR (visible = 'church' AND users.church_campus = ?)", campus) }
  scope :scope_city, -> (city) { joins(:user).where("visible <> 'city' OR (visible = 'city' AND users.city = ?)", city) }

end
