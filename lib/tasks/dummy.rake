desc "This task is called"
task :dummy => :environment do
  events = ScheduledReminder.where("send_at<?", DateTime.now)
  
  events.each do |an_event|
    TwilioController.send_text
    an_event.destroy
  end
end