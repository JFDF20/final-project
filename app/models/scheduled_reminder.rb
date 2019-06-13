# == Schema Information
#
# Table name: scheduled_reminders
#
#  id         :integer          not null, primary key
#  send_at    :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ScheduledReminder < ApplicationRecord
end
