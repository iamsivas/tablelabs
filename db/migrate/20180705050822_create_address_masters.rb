class CreateAddressMasters < ActiveRecord::Migration[5.2]
  def change
    create_table :address_masters do |t|
    	t.integer		:empid
    	t.date			:create_date
    	t.string		:name
    	t.string		:address
    	t.string		:landmark
    end
  end
end
