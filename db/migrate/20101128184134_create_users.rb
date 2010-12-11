class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.column :name, :string, :limit => 60
      t.column :email, :string, :limit => 60
      t.column :username, :string, :limit => 60
      t.column :hashed_password, :string, :limit => 40
      t.column :sha1_salt, :string, :limit => 40
      t.column :confirmed, :boolean, :default => false, :null => false
      #t.boolean :enabled, :default => false, :null => false
      #t.boolean :enabled, :limit => 1, :default => false, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
