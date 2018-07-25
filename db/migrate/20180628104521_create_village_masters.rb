class CreateVillageMasters < ActiveRecord::Migration[5.2]
  def change
    create_table :village_masters do |t|
    	t.integer :country_id
    	t.integer :state_id
    	t.integer	:district_id
			t.integer	:taluk_id
			t.integer	:pincode_id
			t.string	:village_name
    end
  end
end
