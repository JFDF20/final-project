class DidYouGoToBedsController < ApplicationController
  def list
    #this is the main one
    @did_you_go_to_beds = DidYouGoToBed.all

    render("did_you_go_to_bed_templates/list.html.erb")
  end

  def details
    @did_you_go_to_bed = DidYouGoToBed.where({ :id => params.fetch("id_to_display") }).first

    render("did_you_go_to_bed_templates/details.html.erb")
  end

  def blank_form
    @did_you_go_to_bed = DidYouGoToBed.new

    render("did_you_go_to_bed_templates/blank_form.html.erb")
  end

  def save_new_info
    @did_you_go_to_bed = DidYouGoToBed.new

    @did_you_go_to_bed.went_to_bed_yn = params.fetch("went_to_bed_yn")

    if @did_you_go_to_bed.valid?
      @did_you_go_to_bed.save

      redirect_to("/did_you_go_to_beds", { :notice => "Did you go to bed created successfully." })
    else
      render("did_you_go_to_bed_templates/blank_form.html.erb")
    end
  end

  def prefilled_form
    @did_you_go_to_bed = DidYouGoToBed.where({ :id => params.fetch("id_to_prefill") }).first

    render("did_you_go_to_bed_templates/prefilled_form.html.erb")
  end

  def save_edits
    @did_you_go_to_bed = DidYouGoToBed.where({ :id => params.fetch("id_to_modify") }).first

    @did_you_go_to_bed.went_to_bed_yn = params.fetch("went_to_bed_yn")

    if @did_you_go_to_bed.valid?
      @did_you_go_to_bed.save

      redirect_to("/did_you_go_to_beds/" + @did_you_go_to_bed.id.to_s, { :notice => "Did you go to bed updated successfully." })
    else
      render("did_you_go_to_bed_templates/prefilled_form.html.erb")
    end
  end

  def remove_row
    @did_you_go_to_bed = DidYouGoToBed.where({ :id => params.fetch("id_to_remove") }).first

    @did_you_go_to_bed.destroy

    redirect_to("/did_you_go_to_beds", { :notice => "Did you go to bed deleted successfully." })
  end
end
