class CreateDidYouGoToBeds < ActiveRecord::Migration[5.1]
  def change
    create_table :did_you_go_to_beds do |t|
      t.string :went_to_bed_yn

      t.timestamps
    end
  end
end
