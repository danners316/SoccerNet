class AddLeagueColumnToProducts < ActiveRecord::Migration
  def change
    add_column :products, :league, :string
  end
end
