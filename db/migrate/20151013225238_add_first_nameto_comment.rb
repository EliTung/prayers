class AddFirstNametoComment < ActiveRecord::Migration
  def change
  	add_column :comments, :firstname, :boolean
  end
end
