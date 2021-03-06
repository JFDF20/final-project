Rails.application.routes.draw do
  # Routes for the Did you go to bed resource:

  # CREATE
  match("/new_did_you_go_to_bed_form", { :controller => "did_you_go_to_beds", :action => "blank_form", :via => "get" })
  match("/insert_did_you_go_to_bed_record", { :controller => "did_you_go_to_beds", :action => "save_new_info", :via => "post" })

  # READ
  match("/did_you_go_to_beds", { :controller => "did_you_go_to_beds", :action => "list", :via => "get" })
  match("/did_you_go_to_beds/:id_to_display", { :controller => "did_you_go_to_beds", :action => "details", :via => "get" })

  # UPDATE
  match("/existing_did_you_go_to_bed_form/:id_to_prefill", { :controller => "did_you_go_to_beds", :action => "prefilled_form", :via => "get" })
  match("/update_did_you_go_to_bed_record/:id_to_modify", { :controller => "did_you_go_to_beds", :action => "save_edits", :via => "post" })

  # DELETE
  match("/delete_did_you_go_to_bed/:id_to_remove", { :controller => "did_you_go_to_beds", :action => "remove_row", :via => "get" })

  #------------------------------

  # Routes for the Scheduled reminder resource:

  # CREATE
  match("/new_scheduled_reminder_form", { :controller => "scheduled_reminders", :action => "blank_form", :via => "get" })
  match("/insert_scheduled_reminder_record", { :controller => "scheduled_reminders", :action => "save_new_info", :via => "post" })

  # READ
  match("/scheduled_reminders", { :controller => "scheduled_reminders", :action => "list", :via => "get" })
  match("/scheduled_reminders/:id_to_display", { :controller => "scheduled_reminders", :action => "details", :via => "get" })

  # UPDATE
  match("/existing_scheduled_reminder_form/:id_to_prefill", { :controller => "scheduled_reminders", :action => "prefilled_form", :via => "get" })
  match("/update_scheduled_reminder_record/:id_to_modify", { :controller => "scheduled_reminders", :action => "save_edits", :via => "post" })

  # DELETE
  match("/delete_scheduled_reminder/:id_to_remove", { :controller => "scheduled_reminders", :action => "remove_row", :via => "get" })

  #------------------------------

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
   match("/", { :controller => "calendar", :action => "get_events", :via => "get" })
   match("/send_text", { :controller => "twilio", :action => "text_reminder", :via => "post" })

  
end
