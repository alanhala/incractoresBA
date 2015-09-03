class Image < ActiveRecord::Base
  belongs_to :report

  mount_uploader :attachment, AttachmentUploader
end
