class CreatePincodeMasters < ActiveRecord::Migration[5.2]
  def change
    create_table :pincode_masters do |t|
    	t.integer :country_id
    	t.integer :state_id
    	t.integer	:district_id
			t.integer	:taluk_id
			t.string	:pincode
    end
  end
end
