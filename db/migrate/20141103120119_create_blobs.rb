class CreateBlobs < ActiveRecord::Migration
  def change
    create_table :blobs do |t|

      t.timestamps
    end
  end
end
