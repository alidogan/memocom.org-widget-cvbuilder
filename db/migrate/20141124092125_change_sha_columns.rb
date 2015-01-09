class ChangeShaColumns < ActiveRecord::Migration
  def change

  	remove_column :shas, :primary_key, :string

  end
end
