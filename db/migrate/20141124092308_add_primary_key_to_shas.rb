class AddPrimaryKeyToShas < ActiveRecord::Migration
  def change

  	remove_columns :shas, :permanode, :text
  	add_column :shas, :permanode, :primary_key

  end
end
