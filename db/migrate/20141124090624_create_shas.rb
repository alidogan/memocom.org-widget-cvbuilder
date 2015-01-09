class CreateShas < ActiveRecord::Migration
  def change
    create_table :shas, id: false do |t|
    	t.text :permanode, :primary_key
    	t.text :content
    	t.text :filename
    	t.text :extension
    	t.text :filetype
    	t.text :icon
    	t.boolean :public
    	t.boolean :private
    	t.text :thumbnail
    	t.text :download
    	t.text :auth
      	t.timestamps
    end
  end
end
