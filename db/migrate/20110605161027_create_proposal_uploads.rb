class CreateProposalUploads < ActiveRecord::Migration
  def self.up
    create_table :proposal_uploads do |t|
      t.string :file_name
      t.string :content_type
      t.integer :file_size

      t.timestamps
    end
  end

  def self.down
    drop_table :proposal_uploads
  end
end
