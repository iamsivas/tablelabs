class CreateEmpWorksheetCounts < ActiveRecord::Migration[5.2]
  def change
    create_table :emp_worksheet_counts do |t|
    	t.integer		:empid
    	t.integer		:fileid
    	t.integer		:catid
    	t.integer		:logid, :default=>0, :null=>false
    	t.integer		:line_count, :default=>0, :null=>false
    	t.integer		:page_count, :default=>0, :null=>false
        t.date          :create_at
    end
  end
end
