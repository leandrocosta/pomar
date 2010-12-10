class CreateConfirmationKeys < ActiveRecord::Migration
  def self.up
    create_table :confirmation_keys do |t|
      t.column :key, :string, :limit => 40
      t.belongs_to :user
      t.timestamps
    end
  end

  def self.down
    drop_table :confirmation_keys
  end
end
