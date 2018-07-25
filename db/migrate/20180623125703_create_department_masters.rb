class CreateDepartmentMasters < ActiveRecord::Migration[5.2]
  def change
    create_table :department_masters do |t|
    	t.string	:name
    end
  end
end
