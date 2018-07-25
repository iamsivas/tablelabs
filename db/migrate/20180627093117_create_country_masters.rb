class CreateCountryMasters < ActiveRecord::Migration[5.2]
  def change
    create_table :country_masters do |t|
    	t.string :country_name
    	t.string :population
    	t.string :area_size
    	t.string :pupulation_size
    end
  end
end
