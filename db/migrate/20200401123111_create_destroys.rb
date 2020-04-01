class CreateDestroys < ActiveRecord::Migration[5.2]
  def change
    create_table :destroys do |t|
      t.string :Example

      t.timestamps
    end
  end
end
