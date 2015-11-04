class AddEmailtoUsers < ActiveRecord::Migration
  def change
  	add_column :users, :email_subs, :boolean
  	add_column :users, :email_prays, :boolean
  	add_column :users, :email_comms, :boolean
  	rename_column :users, :subscript_frq, :subs_frq
  end
end
