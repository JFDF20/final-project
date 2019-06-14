require 'rubygems'
require 'twilio-ruby'

class TwilioController < ApplicationController

    def text_reminder
        TwilioController.send_text
    end
    
    def self.send_text

        twilio_sid = ENV.fetch("TWILIO_ACCOUNT_SID")
        twilio_token = ENV.fetch("TWILIO_AUTH_TOKEN")
        sms_parameters = {
        :from => ENV.fetch("TWILIO_ASSIGNED_PHONE_NUMBER"),
        :to => ENV.fetch("YOUR_PHONE_NUMBER"),
        :body => "Reminder to go to bed! Record here: https://bedtime-reminder-production.herokuapp.com/did_you_go_to_beds"
        }
        # Set up a client to talk to the Twilio REST API
        @twilio_client = Twilio::REST::Client.new(twilio_sid, twilio_token)
        # Send your message through the client
        call = @twilio_client.messages.create(sms_parameters)
    
        puts call.to
    end
    
end
