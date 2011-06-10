class FixProposalUploadColumnNames < ActiveRecord::Migration
  def self.up
    rename_column :proposal_uploads, :file_name, :upload_file_name
    rename_column :proposal_uploads, :content_type, :upload_content_type
    rename_column :proposal_uploads, :file_size, :upload_file_size
  end

  def self.down
  end
end
