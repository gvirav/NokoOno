require_relative '../config'

class CreateConfessions < ActiveRecord::Migration
  def change
    # HINT: checkout ActiveRecord::Migration.create_table
    create_table :users do |s|
      s.timestamps
    end
    create_table :confessions do |t|
      t.references :user
      t.string :post_id
      t.string :text
    end
  end
end