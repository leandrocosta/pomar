class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :name
      t.string :description
      t.belongs_to :user

      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
