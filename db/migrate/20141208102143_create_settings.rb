class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|

    	t.integer :thumbnail_size
    	t.timestamps
    	
    end
  end
end
