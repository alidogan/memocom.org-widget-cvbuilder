class AddColumnsToContacts < ActiveRecord::Migration
  def change

  	add_column :contacts, :encrypted_first_name, :string
  	add_column :contacts, :encrypted_last_name, :string
  	add_column :contacts, :encrypted_email, :string

  end
end
