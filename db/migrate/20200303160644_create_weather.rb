class CreateWeather < ActiveRecord::Migration[6.0]
  def change
    create_table :weathers do |t|
      t.integer :user_id
      t.integer :location_id
      t.string :city
      t.string :weather_status #rain, snow, etc
      t.float :temp_f #fahrenheit
      t.float :temp_c #celcius
      t.integer :humidity
    end
  end
end
