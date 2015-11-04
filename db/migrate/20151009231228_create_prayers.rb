class CreatePrayers < ActiveRecord::Migration
  def change
    create_table :prayers do |t|
    	t.references :user, index: true
    	t.references :request, index: true
      t.timestamps
    end
  end
end
