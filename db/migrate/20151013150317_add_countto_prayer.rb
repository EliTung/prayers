class AddCounttoPrayer < ActiveRecord::Migration
  def change
  	add_column :prayers, :count, :integer
  end
end
