class AddColumnIdentifierInUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :identifier, :integer
  end
end
