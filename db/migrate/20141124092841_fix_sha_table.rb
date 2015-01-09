class FixShaTable < ActiveRecord::Migration
  def change

  	add_column :shas, :permanode, :text
  	add_column :shas, :id, :primary_key

  end
end
