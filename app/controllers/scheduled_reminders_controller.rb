class ScheduledRemindersController < ApplicationController
  def list
    @scheduled_reminders = ScheduledReminder.all

    render("scheduled_reminder_templates/list.html.erb")
  end

  def details
    @scheduled_reminder = ScheduledReminder.where({ :id => params.fetch("id_to_display") }).first

    render("scheduled_reminder_templates/details.html.erb")
  end

  def blank_form
    @scheduled_reminder = ScheduledReminder.new

    render("scheduled_reminder_templates/blank_form.html.erb")
  end

  def save_new_info
    #creates new db objects to be saved in the scheduled reminders table
    @scheduled_reminder = ScheduledReminder.new

    @scheduled_reminder.send_at = params.fetch("send_at")

    if @scheduled_reminder.valid?
      @scheduled_reminder.save

      redirect_to("/scheduled_reminders", { :notice => "Scheduled reminder created successfully." })
    else
      render("scheduled_reminder_templates/blank_form.html.erb")
    end
  end

  def prefilled_form
    @scheduled_reminder = ScheduledReminder.where({ :id => params.fetch("id_to_prefill") }).first

    render("scheduled_reminder_templates/prefilled_form.html.erb")
  end

  def save_edits
    @scheduled_reminder = ScheduledReminder.where({ :id => params.fetch("id_to_modify") }).first

    @scheduled_reminder.send_at = params.fetch("send_at")

    if @scheduled_reminder.valid?
      @scheduled_reminder.save

      redirect_to("/scheduled_reminders/" + @scheduled_reminder.id.to_s, { :notice => "Scheduled reminder updated successfully." })
    else
      render("scheduled_reminder_templates/prefilled_form.html.erb")
    end
  end

  def remove_row
    @scheduled_reminder = ScheduledReminder.where({ :id => params.fetch("id_to_remove") }).first

    @scheduled_reminder.destroy

    redirect_to("/scheduled_reminders", { :notice => "Scheduled reminder deleted successfully." })
  end
end
