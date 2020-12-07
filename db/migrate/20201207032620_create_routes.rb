class CreateRoutes < ActiveRecord::Migration[6.0]
  def change
    create_table :routes do |t|
      t.datetime :starts_at
      t.datetime :ends_at
      t.integer :load_type
      t.float :load_sum
      t.text :cities
      t.integer :stops_amount

      t.timestamps
    end
  end
end
