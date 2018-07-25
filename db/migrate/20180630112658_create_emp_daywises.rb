class CreateEmpDaywises < ActiveRecord::Migration[5.2]
  def change
    create_table :emp_daywises do |t|
    	t.integer	:empid
    	t.date		:date
    	t.string	:max_hour
    	t.integer	:line_count, :default=>0, :null=>false
    	t.string	:page_count, :default=>0, :null=>false
    end
  end
end
