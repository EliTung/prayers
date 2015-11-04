class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.text :content
      t.references :user, index: true

      t.timestamps
    end
  end
end
