class CreateLoginMasters < ActiveRecord::Migration[5.2]
  def change
    create_table :login_masters do |t|
    	t.integer	:empid
    	t.string  :ip_address
    	t.date 		:log_date
    	t.time 		:login_time
    	t.time 		:logout_time
    end
  end
end
