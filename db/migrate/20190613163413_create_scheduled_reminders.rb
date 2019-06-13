class CreateScheduledReminders < ActiveRecord::Migration[5.1]
  def change
    create_table :scheduled_reminders do |t|
      t.datetime :send_at

      t.timestamps
    end
  end
end
