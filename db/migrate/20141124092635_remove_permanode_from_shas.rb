class RemovePermanodeFromShas < ActiveRecord::Migration
  def change

  	remove_columns :shas, :permanode, :primary_key

  end
end
