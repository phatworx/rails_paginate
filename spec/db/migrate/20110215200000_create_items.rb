class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :dummy
    end
  end
end
