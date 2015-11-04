class AddSubscriptionCount < ActiveRecord::Migration
  def change
  	add_column :subscriptions, :week_count, :integer
  	remove_column :subscriptions, :monthly, :boolean
  	add_column :users, :subscript_frq, :integer
  end
end
