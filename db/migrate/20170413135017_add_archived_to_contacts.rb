class AddArchivedToContacts < ActiveRecord::Migration[5.0]
  def change
  	add_column :contacts, :archived, :boolean, default: false
  end
end
