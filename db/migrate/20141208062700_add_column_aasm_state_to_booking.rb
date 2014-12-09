class AddColumnAasmStateToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :aasm_state, :string
  end
end
