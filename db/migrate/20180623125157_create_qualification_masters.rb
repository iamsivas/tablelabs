class CreateQualificationMasters < ActiveRecord::Migration[5.2]
  def change
    create_table :qualification_masters do |t|
    	t.string	:name
    end
  end
end
