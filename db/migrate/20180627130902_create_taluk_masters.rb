class CreateTalukMasters < ActiveRecord::Migration[5.2]
  def change
    create_table :taluk_masters do |t|
    	t.integer :country_id
    	t.integer :state_id
    	t.integer	:district_id
			t.string	:taluk_name
    end
  end
end
