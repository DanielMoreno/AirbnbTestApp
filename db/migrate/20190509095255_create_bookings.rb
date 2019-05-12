class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      ## Forign Keys - User that is making the booking, and room the booking is for
      t.references :user, foreign_key: true
      t.references :room, foreign_key: true

      ## Dates of booking
      t.date :start_date
      t.date :end_date

      ## Local price so that booking amount not retroactively changed on room edit
      t.integer :price
      t.integer :total

      ## Confirmation message
      t.string :confirmation_message

      ## Statuses
      t.string :confirmation_status
      t.boolean :is_canceled
      
      t.timestamps
    end
  end
end
