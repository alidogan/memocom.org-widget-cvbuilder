class AddDescriptionToShas < ActiveRecord::Migration
  def change
  	add_column :shas, :description, :text
  end
end
