class AddColumnRequest < ActiveRecord::Migration
  def change
  	add_column :requests, :request, :text
  	add_column :requests, :topic, :string
  end
end
