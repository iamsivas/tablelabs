class CreateStateMasters < ActiveRecord::Migration[5.2]
  def change
    create_table :state_masters do |t|
    	t.integer :country_id
      t.string	:state_name
    end
  end
end
