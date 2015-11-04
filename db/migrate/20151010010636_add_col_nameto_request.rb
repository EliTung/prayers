class AddColNametoRequest < ActiveRecord::Migration
  def change
  		add_column :requests, :firstname, :boolean
  end
end
