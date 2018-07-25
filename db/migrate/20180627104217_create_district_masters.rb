class CreateDistrictMasters < ActiveRecord::Migration[5.2]
  def change
    create_table :district_masters do |t|
    	t.integer :country_id
    	t.integer :state_id
    	t.string	:district_name
    end
  end
end
