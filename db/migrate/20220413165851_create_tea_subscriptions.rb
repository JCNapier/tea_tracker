class CreateTeaSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :tea_subscriptions do |t|
      t.references :subscription, foreign_key: true
      t.references :tea, foreign_key: true
    end
  end
end
