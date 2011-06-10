class ProposalUpload < ActiveRecord::Base
  has_attached_file :upload
end
