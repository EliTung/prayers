class AddChurchDetailsUser < ActiveRecord::Migration
  def change
  	add_column :users, :church_campus, :string
  	add_column :users, :fellowship, :string
  end
end
