class CreateEmpFilepaths < ActiveRecord::Migration[5.2]
  def change
    create_table :emp_filepaths do |t|
    	t.integer       :empid
    	t.integer				:logid
      t.string        :file_path
      t.string        :file_name
      t.date          :create_date
    end
  end
end
