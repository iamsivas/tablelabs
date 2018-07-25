class CreateEmployeeProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :employee_profiles do |t|
    	t.integer	:userid, :default=>0, :null=>false
    	t.string 	:door_no
    	t.string 	:street
    	t.string 	:village
    	t.string 	:city
    	t.string 	:pincode
    	t.integer :qualification
    	t.integer :experience
    	t.integer :department
    	t.string	:phone_no
    	t.date		:birth_date
    	t.string	:bank_acc_no
    	t.string	:bank_ifsc
    end
  end
end
