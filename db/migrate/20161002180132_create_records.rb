class CreateRecords < ActiveRecord::Migration
  def change
       create_table :records do |t|
      t.string :artist
      t.string :title
      t.string :label
    end
  end
end
