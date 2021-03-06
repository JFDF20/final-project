require 'google/apis/calendar_v3'
      require 'googleauth'
      require 'googleauth/stores/file_token_store'
      require 'date'
      require 'fileutils'
      
      OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'.freeze
      APPLICATION_NAME = 'Google Calendar API Ruby Quickstart'.freeze
      CREDENTIALS_PATH = Rails.root.join('app', 'controllers', 'credentials.json')
      # The file token.yaml stores the user's access and refresh tokens, and is
      # created automatically when the authorization flow completes for the first
      # time.
      TOKEN_PATH = 'token.yaml'.freeze
      SCOPE = Google::Apis::CalendarV3::AUTH_CALENDAR_READONLY
      
      ##
      # Ensure valid credentials, either by restoring from the saved credentials
      # files or intitiating an OAuth2 authorization. If authorization is required,
      # the user's default browser will be launched to approve the request.
      #
      # @return [Google::Auth::UserRefreshCredentials] OAuth2 credentials

class CalendarController < ApplicationController

    def get_events
      def authorize
        client_id = Google::Auth::ClientId.from_file(CREDENTIALS_PATH)
        token_store = Google::Auth::Stores::FileTokenStore.new(file: TOKEN_PATH)
        authorizer = Google::Auth::UserAuthorizer.new(client_id, SCOPE, token_store)
        user_id = 'default'
        credentials = authorizer.get_credentials(user_id)
        if credentials.nil?
          url = authorizer.get_authorization_url(base_url: OOB_URI)
          puts 'Open the following URL in the browser and enter the ' \
               "resulting code after authorization:\n" + url
          code = '4/ZwHW-xB7ZJx0cHSynM2hSmvuAcqTMOBNB7B7wGWiHsTwnTKbYcwJa6U'
          credentials = authorizer.get_and_store_credentials_from_code(
            user_id: user_id, code: code, base_url: OOB_URI
          )
        end
        credentials
      end

      # Initialize the API
      service = Google::Apis::CalendarV3::CalendarService.new
      service.client_options.application_name = APPLICATION_NAME
      service.authorization = authorize
      
      
      # Fetch the first event tomorrow for the user
      calendar_id = 'primary'
      
      time_zone = "Pacific Time (US & Canada)"
      current_date = DateTime.now.in_time_zone(time_zone)
      min_time = DateTime.new(current_date.year, current_date.month, current_date.day, 1, 0, 0, '-7') + 1
      response = service.list_events(calendar_id,
                                     max_results: 1,
                                     single_events: true,
                                     order_by: 'startTime',
                                     time_min: min_time.rfc3339)
      
      event_title = "No events found"
      event_time = ""
      if not response.items.empty?
        event = response.items.first
        event_title = event.summary
        @event_datetime = event.start.date_time-9.hours
        event_day = event.start.date_time.strftime("%m/%d/%Y")
        event_time = event.start.date_time.strftime("%I:%M %p")
      end
      
      @event_time = event_time
      @event_day = event_day
      
      @event_name = event_title
      
      render("bed_time/event_display_page.html.erb")
    end
end