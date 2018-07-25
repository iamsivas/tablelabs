class CreateEmpMonthwises < ActiveRecord::Migration[5.2]
  def change
    create_table :emp_monthwises do |t|
    	t.integer	:empid
    	t.date		:month
    	t.integer	:line_count, :default=>0, :null=>false
    	t.string	:page_count, :default=>0, :null=>false
    end
  end
end
