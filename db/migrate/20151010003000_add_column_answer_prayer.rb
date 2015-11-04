class AddColumnAnswerPrayer < ActiveRecord::Migration
  def change
  	add_column :requests, :result, :text
  	rename_column :users, :name, :username
  end
end
