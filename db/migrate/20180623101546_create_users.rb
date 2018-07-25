class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
    	t.string 	:name
			t.string 	:email
			t.integer	:empid, :default=>0, :null=>false
			t.integer	:role, :default=>0, :null=>false
			t.integer :deactive, :default=>0, :null=>false
			t.string 	:password_digest
			t.integer :current_status, :default=>0, :null=>false
			
      t.timestamps
    end
  end
end
