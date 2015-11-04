class ChngCountCol < ActiveRecord::Migration
  def change
  	rename_column :prayers, :count, :pr_count
  end
end
