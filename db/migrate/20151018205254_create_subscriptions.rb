class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :user, index: true
      t.references :request, index: true
      t.boolean :monthly
      t.boolean :daily
      t.timestamps
    end
  end
end
