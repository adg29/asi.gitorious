class Proposal < ActiveRecord::Base
  has_many :proposal_uploads
  # only these attributes can be mass assigned
  # attr_accessible :description, :rewards, :url, :terms_accepted

  def to_json(options= {})
    super(options.merge(:only  => [ :id, :description, :rewards, :url, :terms_accepted, :created_at ]))
  end
end
