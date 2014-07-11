class AddCurrencyToFacility < ActiveRecord::Migration
  def change
  	add_column :facilities, :currency, :string
  end
end
