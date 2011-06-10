class AddProposalIdToProposalUploads < ActiveRecord::Migration
  def self.up
    add_column :proposal_uploads, :proposal_id, :integer
  end

  def self.down
    remove_column :proposal_uploads, :proposal_id
  end
end
