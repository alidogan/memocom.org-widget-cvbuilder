class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|

    	t.string :encrypted_name
    	t.timestamps
    end

    create_table :contacts_groups, id: false do |t|

    	t.belongs_to :contact
    	t.belongs_to :group

    end

  end
end
