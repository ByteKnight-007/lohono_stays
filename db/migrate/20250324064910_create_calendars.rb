class CreateCalendars < ActiveRecord::Migration[7.2]
  def change
    create_table :calendars do |t|
      t.references :villa, null: false, foreign_key: true
      t.date :date
      t.integer :price
      t.boolean :available

      t.timestamps
    end
  end
end
