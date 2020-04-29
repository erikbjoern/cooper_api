class CreatePerformanceData < ActiveRecord::Migration[6.0]
  def change
    execute 'CREATE EXTENSION IF NOT EXISTS hstore'
    create_table :performance_data do |t|
      t.references :user
      t.hstore :data

      t.timestamps
    end
  end
end
