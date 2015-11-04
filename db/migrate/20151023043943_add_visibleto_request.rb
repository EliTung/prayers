class AddVisibletoRequest < ActiveRecord::Migration
  def change
  	 add_column :requests, :visible, :string
  end
end
