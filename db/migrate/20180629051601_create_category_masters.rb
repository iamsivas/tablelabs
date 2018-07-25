class CreateCategoryMasters < ActiveRecord::Migration[5.2]
  def change
    create_table :category_masters do |t|
    	t.integer	:parent_id, :default=>0, :null=>false
    	t.string	:cat_name
    end
  end
end
