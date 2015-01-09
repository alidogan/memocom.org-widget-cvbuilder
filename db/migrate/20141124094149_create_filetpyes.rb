class CreateFiletpyes < ActiveRecord::Migration
  def change
    create_table :filetpyes, id: false do |t|

    	t.string :extension
    	t.string :filetype

      t.timestamps
    end
  end
end
