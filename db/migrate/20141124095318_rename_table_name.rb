class RenameTableName < ActiveRecord::Migration
  def change

  	rename_table :filetpyes, :filetypes

  end
end
