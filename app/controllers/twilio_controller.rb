class TwilioController < ApplicationController

    def text_reminder

        twilio_sid = ENV.fetch("TWILIO_ACCOUNT_SID")
        twilio_token = ENV.fetch("TWILIO_AUTH_TOKEN")
        sms_parameters = {
        :from => ENV.fetch("TWILIO_ASSIGNED_PHONE_NUMBER"),
        :to => ENV.fetch("YOUR_PHONE_NUMBER"),
        :body => "Reminder to go to bed!"
        }
        # Set up a client to talk to the Twilio REST API
        twilio_client = Twilio::REST::Client.new(twilio_sid, twilio_token)
        # Send your message through the client
        twilio_client.api.account.messages.create(sms_parameters)
    
        
        render("bed_time/event_display_page.html.erb")
    end
    
    def test

        account_sid = "ACXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" # Your Account SID from www.twilio.com/console
        auth_token = "your_auth_token"   # Your Auth Token from www.twilio.com/console
        
        @client = Twilio::REST::Client.new account_sid, auth_token
        message = @client.messages.create(
            body: "Hello from Ruby",
            :from => ENV.fetch("TWILIO_ASSIGNED_PHONE_NUMBER"),
            :to => ENV.fetch("YOUR_PHONE_NUMBER"))

        puts message.sid 
    end
    
end
