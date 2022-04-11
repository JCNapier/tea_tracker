class AddSubscriptionToTeas < ActiveRecord::Migration[5.2]
  def change
    add_reference :teas, :subscription, foreign_key: true
  end
end
