class CreateEmpLoginwises < ActiveRecord::Migration[5.2]
  def change
    create_table :emp_loginwises do |t|
    	t.integer		:empid
    	t.date			:date
    	t.time			:intime
    	t.time			:outtime
    end
  end
end
