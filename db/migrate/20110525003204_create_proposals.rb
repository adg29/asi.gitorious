class CreateProposals < ActiveRecord::Migration
  def self.up
    create_table :proposals do |t|
      t.text :description
      t.integer :owner_id
      t.string :owner_type
      t.text :rewards
      t.string :url
      t.boolean :terms_accepted
      t.string :status
      t.text :notes
      t.integer :submissions

      t.timestamps
    end
  end

  def self.down
    drop_table :proposals
  end
end
