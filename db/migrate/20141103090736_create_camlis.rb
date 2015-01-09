class CreateCamlis < ActiveRecord::Migration
  def change
    create_table :camlis do |t|

      t.timestamps
    end
  end
end
